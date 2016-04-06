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
        titleLabel.title = pokemon.name
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonToupUpInside(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
