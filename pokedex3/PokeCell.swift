//
//  PokeCell.swift
//  pokedex3
//
//  Created by Suru Layé on 5/11/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
    }
    
    
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokeNameLabel.text = self.pokemon.name.capitalized
        pokeImageView.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
