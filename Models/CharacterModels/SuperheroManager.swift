//
//  SuperheroManager.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 07/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import SwiftyJSON

class SuperheroManager {
    
    
    
    func searchSuperheroes(nameWith: String, completion: ([Character]?, Bool, String) -> Void) {
        
       /* let mySearchArray = arrayHeroes?.filter({ (heroe) -> Bool in
            return heroe.nombre?.lowercased().contains(nameWith.lowercased()) ?? false
        })
        
        if let uMySearchArray = mySearchArray {
            if !uMySearchArray.isEmpty {
                completion(uMySearchArray, true, "")
            }
        }*/
        
        
    }
    
    func getHeroesFromAPI (completion: @escaping ([Character]) -> Void) {
        
        guard let urlToExecute = URL (string: "https://gateway.marvel.com:443/v1/public/characters?apikey=49ebc28ad0354cc1d400f4770c79a818&hash=ff9bf04615bc16746d2526841da84a1e&ts=1" ) else {
            return
        }
        NetworkingClient.execute(urlToExecute) { (json, error) in
            if let error = error  {
                print(error.localizedDescription)
            } else if let json = json {
                let heroJSON = JSON(json)
                let arrayHeroes = HeroJSONParser.parseHeroes(json: heroJSON)
                completion(arrayHeroes)
            }
        }
    }
    


}



