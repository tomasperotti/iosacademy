//
//  ComicDetailViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 06/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import SDWebImage

class ComicDetailViewController: UIViewController {

    
    @IBOutlet weak var idComicLabel: UILabel!
    var heroComic : Comic?
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleComicLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func closeComicDetailModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let id = heroComic?.id {
            idComicLabel.text = "\(id)"
        }
        
        titleComicLabel.text = heroComic?.title
        
        // MARK: TOFIX: get image
        
        /*if let image = heroComic?.image {
            
            comicImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
            
        }*/
        
        descriptionLabel.text = heroComic?.description

        // Do any additional setup after loading the view.
    }
    
    
    

}
