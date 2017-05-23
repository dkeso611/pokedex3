//
//  Pokemon.swift
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
    fileprivate var _nextEvoTxt: String!
    fileprivate var _nextEvoName: String!
    fileprivate var _nextEvoId: String!
    fileprivate var _nextEvoLvl: String!
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
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            return ""
        }
        return _nextEvoId
    }
    
    var nextEvoLvl: String {
        if _nextEvoLvl == nil {
            return ""
        }
        return _nextEvoLvl
    }
    
    var nextEvoText: String {
        if _nextEvoTxt == nil {
            return ""
        }
        return _nextEvoTxt
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
        
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexId)/"
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
                
                if let types  = result["types"].array , types.count > 0  {
//                    print("types array: \(types)")
                    
                    if let name = types[0]["name"].string {
                        
                        self._type = name.capitalized
//                        print("type 1: \(self._type!)")

                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            if let name = types[x]["name"].string {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    print("types: \(self._type)")
                    
                } else {
                    
                    self._type = ""
                }
                
                if let descriptionArray = result["descriptions"].array , descriptionArray.count > 0 {
                    
                    if let url = descriptionArray[0]["resource_uri"].string {
//                        print("url: \(url)")
                        let descURL = "\(BASE_URL)\(url)"
                        
                        Alamofire.request(descURL).responseJSON { response in
                            
                            //Using SwiftyJSON
                            switch response.result {
                            case .success(let value):
                                let result = JSON(value)
                                
//                                print("result: \(result)")
                                
                                if let description = result["description"].string {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
//                                    print("new description: \(newDescription)")
                                    
                                    self._description = newDescription
                                } else {
                                    
                                    self._description = ""
                                }
                                
                                
                            case .failure(let error):
                                print(error)
                            }
                            completed()
                        }
                    }
                }
                
                if let evolutions = result["evolutions"][0]["to"].string {
                    
                    if evolutions.range(of: "mega") == nil {
                        self._nextEvoName = evolutions
                        print(self._nextEvoName)
                    }
                    
                    if let uri = result["evolutions"][0]["resource_uri"].string {
                        let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                        let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                        self._nextEvoId = nextEvoId
                        
                        if let lvlExist = result["evolutions"][0]["level"].int {
                            
                            self._nextEvoLvl = "\(lvlExist)"
                            
                            print("Next evo: \(self._nextEvoLvl)")
                            
                        } else {
                            
                            self._nextEvoLvl = ""
                        }
                        
                        print(self._nextEvoId)
                    }
                }

            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
