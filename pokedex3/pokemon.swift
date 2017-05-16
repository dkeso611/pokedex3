//
//  pokemon.swift
//  pokedex3
//
//  Created by Suru Layé on 5/11/17.
//  Copyright © 2017 Suru Layé. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _nextEvoName: String!
    fileprivate var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var defense: String {
        
        if _defense == nil {
            return ""
        }
        return _defense
    }
    
    var type: String {
        
        if _type == nil {
            return ""
        }
        return _type
    }
    
    var attack: String {
        
        if _attack == nil {
            return ""
        }
        return _attack
    }
    
    var height: String {
        
        if _height == nil {
            return ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            return ""
        }
        return _weight
    }
    
    var nextEvoName: String {
        
        if _nextEvoName == nil {
            return ""
        }
        return _nextEvoName
    }
    
    var description: String {
        
        if _description == nil {
            return ""
        }
        return _description
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails (completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            //Using SwiftyJSON
            switch response.result {
            case .success(let value):
                let result = JSON(value)
                
                if let weight = result["weight"].string {
                    self._weight = weight
                }
                
                if let height = result["height"].string {
                    self._height = height
                }
                
                if let attack = result["attack"].int {
                    self._attack = "\(attack)"
                }
                
                if let defense = result["defense"].int {
                    self._defense = "\(defense)"
                }
                

                
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
