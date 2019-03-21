//
//  CreatorManager.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

// MARK: TOFIX: create CoreData 
class CreatorManager {
    
    // MARK: - TOFIX: harcoded request
    
    static let harcodedRequest = "https://gateway.marvel.com:443/v1/public/creators"+MarvelAPIKeysHandler.PUBLIC_PRIVATE_KEY
    
    static func getCreatorsFromAPI (completion: @escaping ([Creator]) -> Void) {
        
        guard let urlToExecute = URL (string: self.harcodedRequest ) else {
            return
        }

        NetworkingClient.execute(urlToExecute) { (json, error) in
            if let error = error  {
                print(error.localizedDescription)
            } else if let json = json {
                let creatorJSON = JSON(json)
                let arrayCreator = CreatorJSONParser.parseCreators(json: creatorJSON)
                
                completion(arrayCreator)
            
            }
        }
    }
    
}
