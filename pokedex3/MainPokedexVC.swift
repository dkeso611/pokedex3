//
//  MainPokedexVC.swift
//  pokedex3
//
//  Created by Suru Layé on 5/11/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import UIKit

class MainPokedexVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemonArray = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        parsePokemonCSV()
        
        let charmander = Pokemon(name: "Charmander", pokedexId: 4)
        print(charmander.name)
        
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon =  Pokemon(name: name, pokedexId: pokeId)
                pokemonArray.append(pokemon)
            }
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }



}

extension MainPokedexVC: UICollectionViewDelegate {
    
}

extension MainPokedexVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = pokemonArray[indexPath.row]
            
            
            cell.configureCell(pokemon: pokemon)
            
            return cell
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
}

extension MainPokedexVC: UICollectionViewDelegateFlowLayout {
    
}
