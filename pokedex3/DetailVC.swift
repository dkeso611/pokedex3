//
//  DetailVC.swift
//  pokedex3
//
//  Created by Suru Layé on 5/12/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import UIKit


class DetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentEvoImageView: UIImageView!
    @IBOutlet weak var nextEvoImageView: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalized
        pokeImageView.image = UIImage(named: "\(pokemon.pokedexId)")
        pokeIdLabel.text = "\(pokemon.pokedexId)"
        currentEvoImageView.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails {
            //Will only be called after network call is complete
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
//        nextEvoImageView.image = UIImage(named: "\(pokemon.nextEvoId)")

        
        if pokemon.nextEvoName == "" {
            evoLabel.text = "Final Evolution"
            nextEvoImageView.isHidden = true
            
        } else {
            nextEvoImageView.image = UIImage(named: "\(pokemon.nextEvoId)")
            nextEvoImageView.isHidden = false

            evoLabel.text = "Next Evolution: \(pokemon.nextEvoName), Level \(pokemon.nextEvoLvl)"
            

        }
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
