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
    
    static let harcodedRequest = "https://gateway.marvel.com:443/v1/public/comics"+MarvelAPIHandler.PUBLIC_PRIVATE_KEY
    
    /* This function will obtain comics by hero ID or all comics from the API. Insert hero ID if you want to obtain the comics of a particular hero.
     */
    static func getComicsFromAPI (heroID: Int32 = 0, completion: @escaping ([Comic]) -> Void) {
        
        let urlToExecute : URL?
        
        if heroID == 0 {
           
            urlToExecute = URL (string: self.harcodedRequest )
            
        } else {
            
            let buildURL = "https://gateway.marvel.com:443/v1/public/comics" + "/\(heroID)"+MarvelAPIHandler.PUBLIC_PRIVATE_KEY
            urlToExecute = URL (string: buildURL )
            
        }
        
        // MARK: - TOIMP: usar solo 1 metodo que devuelva la lista de comics
        
        MarvelAPIManager.fetchFromAPI(urlToExecute, entityToDecode: "ComicsResponse") {
            
            print("Entra en comic manager")
            
            // MARK: --- TOFIX: No se deberia usar un sleep!!!
            
            sleep(5)
            
            let couldGetComicsList = MarvelAPIManager.fetch(entityToDecode: "ComicsResponse") { (setComics) in
                let comicList = MarvelAPIManager.convertSetToArray(set: setComics) as! [Comic]
                completion(comicList)
            }
            
            if couldGetComicsList {
                print("Pudo obtener la lista de comics")
            }
            
        }
  
    }
    
    
 
}
