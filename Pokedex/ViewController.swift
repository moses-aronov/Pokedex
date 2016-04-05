//
//  ViewController.swift
//  Pokedex
//
//  Created by Moses Aronov on 4/4/16.
//  Copyright © 2016 Moses Aronov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: Variables
    var pokemon = [Pokemon]()
    
    
    //MARK: IBOutlets
    @IBOutlet weak var collection: UICollectionView!
    
    //MARK: ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        parsePokemonCSV()
    }
    
    //MARK: Functions
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
           let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokemonId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokemonId)
                pokemon.append(poke)
            }
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    //MARK: CollectionView Functions
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCollectionViewCell", forIndexPath: indexPath) as? PokemonCollectionViewCell {
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            return cell
        } else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    @IBAction func musicButtonTouchUpInside(sender: AnyObject) {
    }
    

}

