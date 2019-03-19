//
//  TabComicViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import SDWebImage

class TabComicDetailViewController: UIViewController {
    
    var comic : Comic!

    @IBOutlet weak var titleComicTextField: UITextField!
    @IBOutlet weak var descriptionComicTextField: UITextField!
    @IBOutlet weak var detailComicImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = comic.thumbnail.path + "." + comic.thumbnail.ext
        
        detailComicImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
 
        
        titleComicTextField.text = comic.title
        
        // MARK: -TOFIX: no muestra en UI
        descriptionComicTextField.text = comic.comicDescription
        
        // Do any additional setup after loading the view.
    }
    
}
