//
//  pokemon.swift
//  pokedex3
//
//  Created by Suru Layé on 5/11/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var defense: String {
        return _defense
    }
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
    
}
