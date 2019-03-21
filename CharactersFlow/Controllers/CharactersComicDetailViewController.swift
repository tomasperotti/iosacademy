//
//  ComicDetailViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 06/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import SDWebImage

class CharactersComicDetailViewController: UIViewController {

    
    @IBOutlet weak var idComicLabel: UILabel!
    var heroComic : Comic!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleComicLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func closeComicDetailModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        idComicLabel.text = "\(heroComic.id)"
        titleComicLabel.text = heroComic.title
        
        let image = heroComic.thumbnail.path + "." + heroComic.thumbnail.ext

        comicImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
        
        // MARK: TOFIX: no muestra description en UI
        
        if heroComic.comicDescription != nil {
            descriptionLabel.text = heroComic.comicDescription
        } else {
            descriptionLabel.text = "No description available."
        }
        

        // Do any additional setup after loading the view.
    }
    
    
    

}
