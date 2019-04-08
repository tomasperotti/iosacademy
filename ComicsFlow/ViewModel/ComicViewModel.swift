//
//  ComicViewModel.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 21/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import UIKit

protocol ComicViewModelProtocol {
    
    func getComicAtIndex(index: Int) -> Comic?
    func fetchComics(completion: @escaping () -> Void)
    func getComicsCount() -> Int?
    func getImage (index: Int) -> String?
    
}

// MARK: -TOASK: puede ser una clase?

class ComicViewModel: ComicViewModelProtocol {
    
    private var comicList : [Comic]?
 
    init () {
        
        // Networking stuff
       
    }
    
    func getComicAtIndex(index: Int) -> Comic? {
        
        if let list = comicList {
            if list.count - 1 >= index {
                return list[index]
            }
        }
        
        return nil
        
    }
    
    // MARK: -TOASK: ? le manda la responsabilidad de unwrap al cliente?
    
    func fetchComics(completion: @escaping () -> Void) {
  
        ComicManager.getComicsFromAPI(completion: { [weak self] (comicList) in
            
            guard let uSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                uSelf.comicList = comicList
                completion()
            }

        })
            
    }
    
    func getComicsCount() -> Int? {
        return comicList?.count ?? nil
    }
    
    func getImage(index: Int) -> String? {
        
        let urlString = (comicList?[index].thumbnail.path)! + "." + (comicList?[index].thumbnail.ext)!
        return urlString
        
    }
    

}
