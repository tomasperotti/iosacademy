//
//  HeroJSONParser.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 08/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import SwiftyJSON

class HeroJSONParser {
    
    private let networkingClient = NetworkingClient()
    
    static func parseHeroes (json: JSON) -> [Character] {
        
        let arrayHeroesJSON = json["data"]["results"].arrayValue
        var heroArrayParsed : [Character] = []
        
        for dic in arrayHeroesJSON {
            
            let wikiFromHero = getWikiFromHero(arrayOfUrls: dic["urls"].arrayValue)
            
            let hero = Character(id: dic["id"].intValue, name: dic["name"].stringValue, description: dic["description"] != "" ? dic["description"].stringValue : "No description available.", imageName: dic["thumbnail"]["path"].stringValue + "." + dic["thumbnail"]["extension"].stringValue , comic: nil, wikiURL: wikiFromHero)
            heroArrayParsed.append(hero)
            
        }
        
        return heroArrayParsed
      
    }
    
    private static func getWikiFromHero (arrayOfUrls: [JSON]) -> String {
        var wikiURLFromHero = ""
       
        for array in arrayOfUrls {
            if array["type"].stringValue == "wiki" {
                wikiURLFromHero = array["url"].stringValue
                break
            }
        }
        
        return wikiURLFromHero
    }
    
    private static func getJSONComicListFromHero(heroID: Int, completion: @escaping ([JSON]) -> Void) {
        
        let heroIDString = String(heroID)
        let requestFromHeroIDString = "https://gateway.marvel.com:443/v1/public/characters/\(heroIDString+"/comics"+MarvelAPIHandler.PUBLIC_PRIVATE_KEY)"
        let requestFromHeroIDURL = URL (string: requestFromHeroIDString)
        
        if let uRequestFromHeroIDURL = requestFromHeroIDURL {
            NetworkingClient.execute(uRequestFromHeroIDURL) { (json, error) in
                if let error = error  {
                    print(error.localizedDescription)
                } else if let json = json {
                    let comicJSON = JSON(json)
                    completion(comicJSON["data"]["results"].arrayValue)
                }
            }

        }
        
    }
    
    static func parseComics (heroID: Int, completion: @escaping ([Comic]) -> Void)  {

        var comicListParsed = [Comic] ()
       
        getJSONComicListFromHero(heroID: heroID) { (comicListJSON) in
            
            for comicJSON in comicListJSON{
                
                    let newComic = Comic(id: comicJSON["id"].intValue, title: comicJSON["title"].stringValue, description: comicJSON["description"].stringValue , image: comicJSON["thumbnail"]["path"].stringValue + "." + comicJSON["thumbnail"]["extension"].stringValue )
                    comicListParsed.append(newComic)
     
            }
       
            completion(comicListParsed)
            
        }
        
    }
        
    

    
}

