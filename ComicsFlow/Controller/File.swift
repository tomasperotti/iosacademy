//
//  File.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 21/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit

/*class CreatorsViewController: UIViewController {
    
    @IBOutlet weak var table : UITableView!
    @IBOutlet weak var noConnectionLabel : UILabel!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    var viewModel = CreatorsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        
        
        self.initTable()
        
    }
    
    func initTable(){
        self.viewModel.loadCreators() {
            self.activityIndicator.stopAnimating()
            self.table.reloadData()
        }
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let destineViewController = segue.destination as? DetailsViewController
    //        guard let miSender = sender as? UITableViewCell else{return}
    //        guard let index = table.indexPath(for: miSender)?.row else {return}
    //        let miCreator = creators?[index]
    //        let wiki: URLElement? = miCreator!.urls.first(where: { $0.realType == .detail })
    //        let detail = Detail(name: miCreator?.fullName, description: nil, image: miCreator?.thumbnail, wiki : wiki?.url)
    //        destineViewController?.detail = detail
    //
    //    }
}
extension CreatorsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return creators?.count ?? 0
        return self.viewModel.getCreatorsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCelda = table.dequeueReusableCell(withIdentifier: "reusedCell") as! UITableViewCell
        myCelda.textLabel?.text = self.viewModel.getFullName(indexPath.row)
        //myCelda.textLabel?.text = creators?[indexPath.row].fullName
        return myCelda
    }
}
*/
