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
    
    static func parseComics(comicResponse: ComicsResponse) -> [Comic] {
        
        var comicListParsed = [Comic] ()
        
        comicListParsed = Array(comicResponse.data.results)

        return comicListParsed
        
    }
    
    static func parseComicsFromHeroID(heroID: Int, comicResponse: ComicsResponse) -> [Comic] {
        
        var comicListParsed = [Comic] ()
        
        // Do some logic to obtain response from a certain hero
        
        comicListParsed = Array(comicResponse.data.results)
        
        return comicListParsed
        
    }
    
    

}
