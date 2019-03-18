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
  
    static func fetchFromAPI (_ urlToExecute: URL?) {
        
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
                let charResponse: CharactersResponse = try decoder.decode(CharactersResponse.self, from: validData)
                
                /**
                 Ya con el contexto cargado de todas nuestras entidades, llamamos a .save() para
                 efectivamente guardar los registros a nuestra base
                 */
                try context.save()
                
                print("TODO VINO OKA! ::: \(charResponse.data.results.first)")
                
            }
            catch {
                print("ERRORORORORORO")
            }
            
        })
        
        /**
         Necesitamos llamar a .resume() para que la task se ejecute
         */
        dataTask.resume()
    }
    
}


