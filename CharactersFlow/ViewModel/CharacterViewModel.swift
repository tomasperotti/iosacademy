//
//  CharacterViewModel.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 21/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation

struct CharacterViewModel {
    
    var id : Int32
    var title : String
    var comicDescription : String?
    //  esta bien que no lo incluya?  var thumbnail : Thumbnail
    var imageURL : URL?
    
    init (comic: Comic) {
        self.id = comic.id
        self.title = comic.title
        self.comicDescription = comic.comicDescription
        
        if let uImageURL = URL(string: comic.thumbnail.path + "." + comic.thumbnail.ext) {
            self.imageURL = uImageURL
        }
        
    }
    
}
