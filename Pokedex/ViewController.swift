//
//  ViewController.swift
//  Pokedex
//
//  Created by Moses Aronov on 4/4/16.
//  Copyright © 2016 Moses Aronov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UIGestureRecognizerDelegate {
    //MARK: Variables
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    //MARK: IBOutlets
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        initAudio()
        parsePokemonCSV()
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard(_:)))
//        tapGestureRecognizer.delegate = self
//        self.collection?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MarK: Overrides
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailViewController"{
            if let pokemonDetailViewController = segue.destinationViewController as? PokemonDetailViewController{
                if let poke = sender as? Pokemon{
                    pokemonDetailViewController.pokemon = poke
                }
            }
        }
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
    
    func initAudio(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        
        } catch let error as NSError{
            print(error.debugDescription)
        }
        
    }
//    func gestureRecognizer(_: UIGestureRecognizer,
//                           shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
//        return true
//    }
//    
//    func dismissKeyboard(gesture: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
//    

    
    //MARK: CollectionView Functions
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCollectionViewCell", forIndexPath: indexPath) as? PokemonCollectionViewCell {
            let poke: Pokemon!
            if inSearchMode{
                poke = filteredPokemon[indexPath.row]
            } else{
                poke = pokemon[indexPath.row]
            }
            
            
            cell.configureCell(poke)
            return cell
        } else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poke: Pokemon!
        
        if inSearchMode{
           poke = filteredPokemon[indexPath.row]
        } else{
            poke = pokemon[indexPath.row]
        }
        print(poke.name)
        performSegueWithIdentifier("PokemonDetailViewController", sender: poke)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    
    //MARK: Searchbar Functions
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    //MARK: IBActions
    @IBAction func musicButtonTouchUpInside(sender: UIButton!) {
        
        if musicPlayer.playing{
            musicPlayer.stop()
            sender.alpha = 0.2
        } else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    


}

