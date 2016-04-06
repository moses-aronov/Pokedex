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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolution: String!
    
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