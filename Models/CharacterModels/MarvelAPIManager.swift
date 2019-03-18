//
//  MarvelAPIManager.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 18/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MarvelAPIManager {
    
    static var urlSession : URLSession!
  
    static func fetchFromAPI (_ urlToExecute: URL?, entityToDecode: String) {
        
        /**
         Primero necesitamos acceder al contexto.
         */
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let urlToExecute = urlToExecute else {
            return
        }
        
        let urlRequest = URLRequest(url: urlToExecute)
        
        /**
         inicialiamos URLSession y obtenemos una task. Esta task representa al servicio. Una vez que la API
         nos devuelva la respuesta, se va a ejecutar el closure
         */
        self.urlSession = URLSession(configuration: .default)
        
        let dataTask = self.urlSession.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let validData = data else {
                return
            }
            do {
                /** Parseamos la data */
                let decoder = JSONDecoder()
                /** Seteamos la referencia al context */
                decoder.userInfo[CodingUserInfoKey.context!] = context
                
                /**
                 Una vez que ya tenemos la referencia al context, podemos decodear.
                 Al momento de decodear, se van a ir llamando todos los init(from Decoder...) de nuestros modelos,
                 cada init va metiendo entidades en el context
                 */
                switch entityToDecode {
                    
                    case "Characters" :
                            let charResponse: CharactersResponse = try decoder.decode(CharactersResponse.self, from: validData)
                            print("TODO VINO OKA en characters! ::: \(charResponse.data.results.first)")
                    
                    case "Comics" :
                            let comicResponse: ComicsResponse = try decoder.decode(ComicsResponse.self, from: validData)
                            print("TODO VINO OK en comics! ::: \(comicResponse.data.results.first)")
                    
                    default :
                            print("Not valid entity to decode!! You can use: Characters or Comics")
                }
                
                /**
                 Ya con el contexto cargado de todas nuestras entidades, llamamos a .save() para
                 efectivamente guardar los registros a nuestra base
                 */
                try context.save()
                
                
                
            }
            catch {
                print("Error while fetching from API.")
            }
            
        })
        
        /**
         Necesitamos llamar a .resume() para que la task se ejecute
         */
        dataTask.resume()
    }
    
    
    static func convertSetToArray (set: Set<NSManagedObject>?) -> [Any] {
        
        if let set = set {
            return Array(set)
        } else {
            return []
        }
        
    }
    
    
    /**
     Ejecuta una query para obtener una lista de objetos Characters o Comics que tengamos almacenada
     en nuestra base.
     */
    static func fetch(entityToDecode: String, completion: (Set<NSManagedObject>?) -> Void) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        switch entityToDecode {
           
            case "CharactersResponse" :
                
                do {
                    
                    let fetchRequest = NSFetchRequest<CharactersResponse>(entityName: "CharactersResponse")
                    // MARK: -TOSEE:  Devuelve solo la primera response con una lista de heroes
                    let charResponseList = try context.fetch(fetchRequest)
                    completion(charResponseList[0].data.results)
                    
                    return !charResponseList.isEmpty
                
                } catch let error {
                    print("FALLO EL FETCH :: \(error)")
                    completion(nil)
                    return false
                }
                
            

            case "ComicsResponse":
               
                do {
                    
                    let fetchRequest = NSFetchRequest<ComicsResponse>(entityName: "ComicsResponse")
                    let comicResponseList = try context.fetch(fetchRequest)
                    completion(comicResponseList[0].data.results)
                    
                    return !comicResponseList.isEmpty
                    
                }   catch let error {
                    print("FALLO EL FETCH :: \(error)")
                    completion(nil)
                    return false
                }
            
            
            default:
                print("You have to select a valid entity to decode. You can choose from: ComicsResponse and CharactersResponse")
                completion(nil)
                return false
        }
        
    }
    
    /**
     En este caso, hacemos un fetch para obtener todos los objetos CharactersResponse que tengamos almacenados
     en la base. Dependiendo del valor del booleano, va a borrar el primero o todos / SOLO BORRA CHARRESPONSE /
     */
    func delete(context: NSManagedObjectContext, onlyFirstValue: Bool) {
       
        
        do {
            if onlyFirstValue {
                let fetchRequest = NSFetchRequest<CharactersResponse>(entityName: "CharactersResponse")
                let results = try context.fetch(fetchRequest)
                if let aFirst = results.first {
                    context.delete(aFirst)
                }
            }
            else {
                let fetchRequest = NSFetchRequest<CharactersResponse>(entityName: "CharactersResponse")
                let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
                
                try context.execute(batchDelete)
            }
        }
        catch let error {
            print("FALLO EL DELETE! :: \(error)")
        }
    }
    
}


