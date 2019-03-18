//
//  SuperheroManager.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 07/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class SuperheroManager {
    
    var urlSession: URLSession!
    
    // MARK: TODO: Search superheroes to fix
    func searchSuperheroes(nameWith: String, completion: ([Character]?, Bool, String) -> Void) {
        
       /* let mySearchArray = arrayHeroes?.filter({ (heroe) -> Bool in
            return heroe.nombre?.lowercased().contains(nameWith.lowercased()) ?? false
        })
        
        if let uMySearchArray = mySearchArray {
            if !uMySearchArray.isEmpty {
                completion(uMySearchArray, true, "")
            }
        }*/
        
        
    }
    
    func getHeroes (completion: ([Character]) -> Void) {
        
        // MARK: TOFIX: Harcoded request
        
        /*
        if (MarvelAPIManager.fetch(entityToDecode: "CharacterResponse", completion: { (characterSet) in
            if let charSet = characterSet {
                completion(MarvelAPIManager.convertSetToArray(set: charSet) as! [Character])
            }
        })) {
            print("Fetched from local. ")
        } else {
            
            let urlToRequest = URL(string: "https://gateway.marvel.com:443/v1/public/characters?apikey=49ebc28ad0354cc1d400f4770c79a818&hash=ff9bf04615bc16746d2526841da84a1e&ts=1")
            
            MarvelAPIManager.fetchFromAPI(urlToRequest, entityToDecode: "CharactersResponse")
            
            let canFetchLocally = MarvelAPIManager.fetch(entityToDecode: "CharactersResponse") { (characterSet) in
                if let charSet = characterSet {
                    completion(MarvelAPIManager.convertSetToArray(set: charSet) as! [Character])
                }
            }
            
            if canFetchLocally {
                print("Pudo obtener los heroes localmente")
            }
         }
          */
        
        let urlToRequest = URL(string: "https://gateway.marvel.com:443/v1/public/characters?apikey=49ebc28ad0354cc1d400f4770c79a818&hash=ff9bf04615bc16746d2526841da84a1e&ts=1")
        
        MarvelAPIManager.fetchFromAPI(urlToRequest, entityToDecode: "CharactersResponse") {
          
            print("entro en completion")
            let couldGetComicsList = MarvelAPIManager.fetch(entityToDecode: "CharactersResponse") { (setComics) in
                let charactersArray = MarvelAPIManager.convertSetToArray(set: setComics) as! [Character]
                
                completion(charactersArray)
            }
            
            if couldGetComicsList {
                print("Pudo obtener la lista de heroes")
            }
        }
        
        
            
    }
    
}



