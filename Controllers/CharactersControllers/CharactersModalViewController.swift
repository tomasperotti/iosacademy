//
//  HeroModalViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 01/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit

class CharactersModalViewController: UIViewController {

    @IBOutlet weak var heroImageView: UIImageView!
    var imageHeroView : UIImage?
    
    @IBAction func closeHeroModalView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroImageView.image = imageHeroView
        
        // Do any additional setup after loading the view.
    }
    
}
