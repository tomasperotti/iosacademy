//
//  ComicManager.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ComicManager {
    
    static let harcodedRequest = "https://gateway.marvel.com:443/v1/public/comics"+MarvelAPIKeysHandler.PUBLIC_PRIVATE_KEY
    
    /* This function will obtain comics by hero ID or all comics from the API. Insert hero ID if you want to obtain the comics of a particular hero.
     */
    static func getComicsFromAPI (heroID: Int32 = 0, completion: @escaping ([Comic]) -> Void) {
        
        let urlToExecute : URL?
        
        if heroID == 0 {
           
            urlToExecute = URL (string: self.harcodedRequest )
            
        } else {
            
            //https://gateway.marvel.com:443/v1/public/characters/1011334/comics?apikey=49ebc28ad0354cc1d400f4770c79a818

            let buildURL = "https://gateway.marvel.com:443/v1/public/characters" + "/\(heroID)/comics"+MarvelAPIKeysHandler.PUBLIC_PRIVATE_KEY
            urlToExecute = URL (string: buildURL )
            
        }
        
        // MARK: - TOIMP: usar solo 1 metodo que devuelva la lista de comics
        
        MarvelAPIManager.fetchFromAPI(urlToExecute, entityToDecode: ComicsResponse.self) { response in
            
            DispatchQueue.main.async {
                let couldGetComicsList = MarvelAPIManager.fetch(entityToDecode: .ComicsResponse) { (setComics) in
                    let comicList = MarvelAPIManager.convertSetToArray(set: setComics) as! [Comic]
                    completion(comicList)
                }
            }
            
 
        }
  
    }
    
    
 
}
