//
//  Pokemon.swift
//  Pokedex
//
//  Created by Moses Aronov on 4/4/16.
//  Copyright © 2016 Moses Aronov. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    //MARK: Variables
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _pokemonURL:String!
    private var _nextEvolution: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    
    //MARK: Getters
    var name: String{
        if _name == nil{
            _name = ""
        }
        return self._name
    }
    
    var pokedexId: Int{
        return self._pokedexId
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type:String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        
        return _defense
    }
    
    var height:String{
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolution: String{
        if _nextEvolution == nil{
            _nextEvolution = ""
        }
        return _nextEvolution
    }
    
    var nextEvolutionID: String{
        if _nextEvolutionID == nil{
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    var nextEvolutionLevel: String{
        if _nextEvolutionLevel == nil{
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    
    //MARK: Init
    init(name:String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonURL = "\(URL_Base)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, url).responseJSON{ response in
            if let dictionary = response.result.value as? Dictionary<String, AnyObject>{
                if let weight = dictionary["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dictionary["height"] as? String{
                    self._height = height
                }
                
                if let attack = dictionary["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dictionary["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dictionary["types"] as? [Dictionary<String, String>] where types.count > 0{
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    if types.count > 1{
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"]{
                            self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    
                }
                else{
                    self._type = ""
                }
                print(self._type)
                
                if let descriptionArray = dictionary["descriptions"] as? [Dictionary<String, String>] where descriptionArray.count > 0{
                    if let url = descriptionArray[0]["resource_uri"]{
                        let nsurl = NSURL(string: "\(URL_Base)\(url)")
                        Alamofire.request(.GET, nsurl!).responseJSON{ response in
                            if let descriptionDictionary = response.result.value as? Dictionary<String, AnyObject>{
                                if let description = descriptionDictionary["description"] as? String{
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dictionary["evolutions"] as? [Dictionary<String, AnyObject>]
                    where evolutions.count > 0{
                    if let to = evolutions[0]["to"] as? String{
                        if to.rangeOfString("mega") == nil{
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionID = num
                                self._nextEvolution = to
                                
                                if let level = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                
                                print(self._nextEvolutionID)
                                print("Level: \(self._nextEvolutionLevel)")
                                print(self._nextEvolution)
                            }
                        }
                    }
                }
            }
        }
    }
}