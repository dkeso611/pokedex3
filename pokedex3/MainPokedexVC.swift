//
//  MainPokedexVC.swift
//  pokedex3
//
//  Created by Suru Layé on 5/11/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import UIKit
import AVFoundation

class MainPokedexVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemonArray = [Pokemon]()
    var filteredPokemonArray = [Pokemon]()
    var inSearchMode = false
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "pokeMusic", ofType: "mp3")!
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
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

    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.3
            
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailVC" {
            if let detailVC = segue.destination as? DetailVC {
                if let pokemon = sender as? Pokemon {
                    detailVC.pokemon = pokemon
                }
            }
        }
    }


}

extension MainPokedexVC: UICollectionViewDelegate {
    
}

extension MainPokedexVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                
                pokemon = filteredPokemonArray[indexPath.row]
                cell.configureCell(pokemon: pokemon)
                
            } else  {
                
                pokemon = pokemonArray[indexPath.row]
                cell.configureCell(pokemon: pokemon)
            }
            
            
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pokemon: Pokemon!
        
        if inSearchMode {
            
            pokemon = filteredPokemonArray[indexPath.row]
            
        } else {
            
            pokemon = pokemonArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "showDetailVC", sender: pokemon)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if inSearchMode {
            
            return filteredPokemonArray.count
        }
         
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

extension MainPokedexVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            
            filteredPokemonArray = pokemonArray.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
            //$0 is a place holder for each item in the array. ie, taking the name if each pokemon object and checking of the text from searchbar is contained in that name
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
}
