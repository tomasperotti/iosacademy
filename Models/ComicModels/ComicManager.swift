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

    static func getComicsFromAPI (heroID: Int = 0, completion: @escaping ([Comic]) -> Void) {
        
        let urlToExecute : URL?
        
        if heroID == 0 {
           
            urlToExecute = URL (string: self.harcodedRequest )
            
        } else {
            
            let buildURL = "https://gateway.marvel.com:443/v1/public/comics" + "/\(heroID)"+MarvelAPIHandler.PUBLIC_PRIVATE_KEY
            urlToExecute = URL (string: buildURL )
            
        }
        
        
        print("LA URL es: \(urlToExecute)")
        
        // MARK: - TOIMP: usar solo 1 metodo que devuelva la lista de comics
        
        MarvelAPIManager.fetchFromAPI(urlToExecute, entityToDecode: "ComicsResponse") {
            
            // MARK: ESTE CODIGO NO LO EJECUTA !!!
            
            let couldGetComicsList = MarvelAPIManager.fetch(entityToDecode: "ComicsResponse") { (setComics) in
                completion(MarvelAPIManager.convertSetToArray(set: setComics) as! [Comic])
            }
            
            if couldGetComicsList {
                print("Pudo obtener la lista de comics")
            }
        }
        
        
  
    }
 
}
