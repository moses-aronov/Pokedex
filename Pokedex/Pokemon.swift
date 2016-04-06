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
    private var _nextEvolution: String!
    private var _pokemonURL:String!
    
    
    //MARK: Getters
    var name: String{
        return self._name
    }
    
    var pokedexId: Int{
        return self._pokedexId
    }
    
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
            }
        }
    }
}