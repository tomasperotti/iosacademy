//
//  CreatorJSONParser.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import SwiftyJSON

class CreatorJSONParser {
    
    static func parseCreators(json: JSON) -> [Creator] {
        
        let creatorListJSON = json["data"]["results"].arrayValue
        var creatorListParsed = [Creator] ()
        
        for creatorJSON in creatorListJSON {
            
            let newCreator = Creator(name: creatorJSON["fullName"].stringValue, image: creatorJSON["thumbnail"]["path"].stringValue + "." + creatorJSON["thumbnail"]["extension"].stringValue)
      
            creatorListParsed.append(newCreator)
            
        }
        
        
        return creatorListParsed
        
    }
    
}
