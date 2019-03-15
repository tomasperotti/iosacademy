//
//  ComicViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 01/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {

    @IBOutlet weak var idComicLabel: UILabel!
    @IBOutlet weak var titleComicLabel: UILabel!
    var comic : Comic?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idComicLabel.text = "\(comic?.id)"
        titleComicLabel.text = comic?.title

        // Do any additional setup after loading the view.
    }
    

}
