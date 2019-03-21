//
//  NetworkingClient.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 08/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//
import Foundation
import Alamofire

class NetworkingClient {
    
    // MARK: TODO - Hacer singleton
    typealias WebServiceResponse = (Any?, Error?) -> Void
    
    static func execute (_ url: URL, completion: @escaping WebServiceResponse) {
        
        Alamofire.request(url).validate().responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
            } else {
                completion(response.result.value, nil)
            }
            
        }
    }
    
}
