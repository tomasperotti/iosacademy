//
//  example.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 21/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation

/*class CreatorsViewModel{
    private var networking: Networkable?
    private var creators : [Creator]?
    var isLoading: Bool
    
    init (){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //        self.noConnectionLabel.isHidden = Connectivity.isConnectedToInternet()
        self.networking = Networking(context: context)
        self.isLoading = false
        
    }
    
    func loadCreators( finish: @escaping ()-> Void){
        self.isLoading = true
        self.networking?.getElements(url: "creators", toParse: ResponseCreator.self, limit: 50, completion: { [weak self]
            response in
            guard let strongSelf = self else {return}
            strongSelf.creators = response.data.results.filter({ (Creator) -> Bool in
                !Creator.fullName.isEmpty
            })
            strongSelf.isLoading = false
            finish()
        })
    }
    func getCreatorsCount() -> Int{
        return creators?.count ?? 0
    }
    
    func getFullName(_ i: Int)-> String{
        return self.creators?[i].fullName ?? ""
    }
    func loading()-> Bool{
        return isLoading
    }
    
    
}*/
