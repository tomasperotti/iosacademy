//
//  ComicJSONParser.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import SwiftyJSON

class ComicJSONParser {
    
    static func parseComics(json: JSON) -> [Comic] {
        
        let comicListJSON = json["data"]["results"].arrayValue
        var comicListParsed = [Comic] ()
        
        for comicJSON in comicListJSON {
            
            let newComic = Comic(id: comicJSON["id"].intValue, title: comicJSON["title"].stringValue, description: comicJSON["description"].stringValue , image: comicJSON["thumbnail"]["path"].stringValue + "." + comicJSON["thumbnail"]["extension"].stringValue )
            comicListParsed.append(newComic)
            
        }
        
        return comicListParsed
        
    }

}
