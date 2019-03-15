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

    static func getComicsFromAPI (completion: @escaping ([Comic]) -> Void) {
        
        guard let urlToExecute = URL (string: self.harcodedRequest ) else {
            return
        }
        
        print("LA URL es: \(urlToExecute)")
        
        NetworkingClient.execute(urlToExecute) { (json, error) in
            if let error = error  {
                print(error.localizedDescription)
            } else if let json = json {
                let comicJSON = JSON(json)
                let arrayComic = ComicJSONParser.parseComics(json: comicJSON)
                completion(arrayComic)
            }
        }
    }
    
}
