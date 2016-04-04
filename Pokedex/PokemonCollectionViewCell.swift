//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Moses Aronov on 4/4/16.
//  Copyright © 2016 Moses Aronov. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var thumbnailLabel: UILabel!
    
    //MARK: Variables
    var pokemon: Pokemon!
    
    //MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    //MARK: Functions
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        thumbnailLabel.text = self.pokemon.name.capitalizedString
        thumbnailImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
    
}
