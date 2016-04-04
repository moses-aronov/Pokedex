//
//  Pokemon.swift
//  Pokedex
//
//  Created by Moses Aronov on 4/4/16.
//  Copyright © 2016 Moses Aronov. All rights reserved.
//

import Foundation

class Pokemon {
    //MARK: Variables
    private var _name: String!
    private var _pokedexId: Int!
    
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
    }
    
}