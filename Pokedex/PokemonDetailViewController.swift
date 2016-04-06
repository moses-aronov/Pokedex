//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Moses Aronov on 4/5/16.
//  Copyright © 2016 Moses Aronov. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon!
   
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabelValue: UILabel!
    @IBOutlet weak var defenseLabelValue: UILabel!
    @IBOutlet weak var heightLabelValue: UILabel!
    @IBOutlet weak var pokedexIDLabelValue: UILabel!
    @IBOutlet weak var baseAttackLabelValue: UILabel!
    @IBOutlet weak var weightLabelValue: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentPokemonImage = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = currentPokemonImage
        currentEvolutionImage.image = currentPokemonImage
        
        pokemon.downloadPokemonDetails { () -> () in
            print("Did we get here")
            self.updateUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        titleLabel.title = pokemon.name
        
        typeLabelValue.text = pokemon.type
        defenseLabelValue.text = pokemon.defense
        heightLabelValue.text = pokemon.height
        pokedexIDLabelValue.text = "\(pokemon.pokedexId)"
        baseAttackLabelValue.text = pokemon.attack
        weightLabelValue.text = pokemon.weight
        descriptionLabel.text = pokemon.description
        if pokemon.nextEvolutionID == ""{
            nextEvolutionLabel.text = "No Evolutions"
            nextEvolutionImage.hidden = true
        
        } else{
            nextEvolutionImage.hidden = false
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionID)
            var str = "Next Evolution: \(pokemon.nextEvolution)"
            
            if pokemon.nextEvolutionLevel != ""{
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            nextEvolutionLabel.text = str
        }
        
    }

    @IBAction func backButtonToupUpInside(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
