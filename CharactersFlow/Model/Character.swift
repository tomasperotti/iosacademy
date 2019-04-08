//
//  Character.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 27/02/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import CoreData

enum ModelEntities: String {
    case Characters
    case CharactersResponse
    case ComicsResponse
}


/**
 Necesitamos definir una CodingUserInfoKey nueva para poder guardar nuestro context en el decoder.
 Entonces declaramos una extension de CodingUserInfoKey y una key nueva estatica
 */
extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

/**
 Definimos un protocolo para tener la validacion del context en un solo lugar y poder
 reutilizarla en todos nuestros modelos
 */
protocol CodableHasContextChecker {
    
    /**
     Necesitamos pasarle el decoder y el nombre de la entidad que vamos a buscar en el Model de CoreData
     Devuelve una tupla con la entidad y el contexto
     */
    static func hasValidContext(decoder: Decoder, entityName: String) -> (NSEntityDescription, NSManagedObjectContext)?
}

/**
 Definimos una implmentacion por default de la funcion del protocolo.
 Asi todo objeto que se conforme a este protocolo ya va a tener acceso a esta
 implementacion "gratis" :P
 */
extension CodableHasContextChecker {
    static func hasValidContext(decoder: Decoder, entityName: String) -> (NSEntityDescription, NSManagedObjectContext)? {
        /*
         Obtenemos la key que definimos. Esto es un optional y hay que unwrappearlo porque
         internamente es un enum, y los enum pueden fallar al inicializarse
         */
        guard let contextUserInfoKey = CodingUserInfoKey.context else {
            return nil
        }
        
        /**
         Una vez que tenemos la key, pedimos el context que pasamos por referencia al decoder
         */
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else {
            return nil
        }
        
        /**
         Ya con la key y el context podemos buscar la entidad en el Modelo de CoreData
         */
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext) else {
            return nil
        }
        
        /**
         Si todo salio bien, devolvemos la entidad y el context
         */
        return (entity, managedObjectContext)
    }
}


class CharactersResponse: NSManagedObject, Decodable, CodableHasContextChecker {
    @NSManaged var data: CharactersData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let ent = CharactersResponse.hasValidContext(decoder: decoder, entityName: "CharactersResponse") else {
            fatalError("Failed to decode Subject!")
        }
        
        /**
         Necesitamos llamar a nuestro designated initializer para insertar
         una entidad nueva en el contexto
         */
        self.init(entity: ent.0, insertInto: ent.1)
        
        /**
         Luego parseamos los datos normalmente
         */
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(CharactersData.self, forKey: .data)
    }
    
}

class CharactersData: NSManagedObject, Decodable {
    @NSManaged var total: Int32
    @NSManaged var count: Int32
    @NSManaged var results: Set<Character>
    
    enum CodingKeys: String, CodingKey {
        case total
        case count
        case results
    }
    
    
    required convenience init(from decoder: Decoder) throws {
        guard let ent = CharactersResponse.hasValidContext(decoder: decoder, entityName: "CharactersData") else {
            fatalError("Failed to decode Subject!")
        }
        
        self.init(entity: ent.0, insertInto: ent.1)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(Int32.self, forKey: .total)
        self.count = try container.decode(Int32.self, forKey: .count)
        self.results = try container.decode(Set<Character>.self, forKey: .results)
    }
    
}

class Character : NSManagedObject, Decodable {
    
    @NSManaged var id: Int32
    @NSManaged var name : String
    @NSManaged var heroDescription : String
    @NSManaged var urls: Set<URLs>
    @NSManaged var thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case heroDescription = "description"
        case urls
        case thumbnail
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let ent = CharactersResponse.hasValidContext(decoder: decoder, entityName: "Character") else {
            fatalError("Failed to decode Subject!")
        }
        
        self.init(entity: ent.0, insertInto: ent.1)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.heroDescription = try container.decode(String.self, forKey: .heroDescription)
        self.urls = try container.decode(Set<URLs>.self, forKey: .urls)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        
    }
    
    
}

class Thumbnail: NSManagedObject, Decodable {
   
    @NSManaged var path : String
    @NSManaged var ext : String
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let ent = CharactersResponse.hasValidContext(decoder: decoder, entityName: "Thumbnail") else {
            fatalError("Failed to decode Subject!")
        }
        
        self.init(entity: ent.0, insertInto: ent.1)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.ext = try container.decode(String.self, forKey: .ext)
      
    }
   
}


enum URLType: String, Decodable {
  
    case wiki
    case detail
    case comiclink
    
}

class URLs: NSManagedObject, Decodable {
    /**
     CoreData no tiene tipo de dato "enum", entonces tenemos que parsear el valor del enum
     y luego generar un enum con dicho valor.
     
     Como no queremos usar esta property mas que para almacenar el valor del modelo de CoreData,
     la declaramos como privada
     */
    @NSManaged private var type: String
    @NSManaged var url: String
    
    /**
     Este es el valor veradero que queremos exponer de esta clase. Queremos que el type en
     vez de ser usado como un string, sea usado como un enum. Para eso, declaramos
     una propiedad readonly que devuelve el valor de type convertido a un enum
     */
    var realType: URLType {
        return URLType(rawValue: self.type)!
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "URLs", in: managedObjectContext) else {
                fatalError("Failed to decode Subject!")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        /**
         Type lo parseamos como un string porque es el tipo de dato que tiene CoreData y el
         tipo de dato en el JSON
         */
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode(String.self, forKey: .url)
    }
    
}




