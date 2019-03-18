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

    static func getAllComicsFromAPI (completion: @escaping ([Comic]) -> Void) {
        
        guard let urlToExecute = URL (string: self.harcodedRequest ) else {
            return
        }
        
        print("LA URL es: \(urlToExecute)")
        
        //MarvelAPIManager.fetchFromAPI(URL(string: harcodedRequest))
        
        //let arrayComic = ComicJSONParser.parseComics(comicResponse: MarvelAPIManager.)
        completion(arrayComic)
        
        
    }
    
    static func getComicsFromHero (heroID: Int, completion: @escaping ([Comic]) -> Void) {
        
        guard let urlToExecute = URL (string: self.harcodedRequest ) else {
            return
        }
        
        print("LA URL es: \(urlToExecute)")
        
        NetworkingClient.execute(urlToExecute) { (json, error) in
            if let error = error  {
                print(error.localizedDescription)
            } else if let json = json {
                
                // MARK: TODO: get comics from hero id
                
                
                
               
            }
        }
    }
    
    
    
}
