//
//  Comic.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 01/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//
import CoreData

class ComicsResponse: NSManagedObject, Decodable, CodableHasContextChecker {
    
    @NSManaged var data : ComicsData

    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let ent = CharactersResponse.hasValidContext(decoder: decoder, entityName: "ComicsResponse") else {
            fatalError("Failed to decode Subject!")
        }
        
        self.init(entity: ent.0, insertInto: ent.1)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ComicsData.self, forKey: .data)
        
    }
    
}

class ComicsData: NSManagedObject, Decodable {
    
    @NSManaged var results : Set<Comic>
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let ent = CharactersResponse.hasValidContext(decoder: decoder, entityName: "ComicsData") else {
            fatalError("Failed to decode Subject!")
        }
        
        self.init(entity: ent.0, insertInto: ent.1)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode(Set<Comic>.self, forKey: .results)
        
    }
    
}

class Comic: NSManagedObject, Decodable {
    
    @NSManaged var id : Int32
    @NSManaged var title : String
    @NSManaged var comicDescription : String?
    @NSManaged var thumbnail : Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case comicDescription = "description"
        case thumbnail
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let ent = CharactersResponse.hasValidContext(decoder: decoder, entityName: "Comic") else {
            fatalError("Failed to decode Subject!")
        }
        
        self.init(entity: ent.0, insertInto: ent.1)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.comicDescription = try container.decode(Optional.self, forKey: .comicDescription)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        
    }
    
}



