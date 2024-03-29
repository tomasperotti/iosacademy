//
//  TabComicViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import SDWebImage

class ComicDetailViewController: UIViewController {
    
    var comic : Comic!

    @IBOutlet weak var titleComicTextField: UITextField!
    @IBOutlet weak var descriptionComicTextField: UITextField!
    @IBOutlet weak var detailComicImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        let image = comic.thumbnail.path + "." + comic.thumbnail.ext
        
        detailComicImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
 
        
        titleComicTextField.text = comic.title
        
        // MARK: -TOFIX: No obtiene la description del JSON
        
        if comic.comicDescription != nil  {
            descriptionComicTextField.text = comic.comicDescription
        } else {
            descriptionComicTextField.text = "No description available."
        }

    }
    
    func setupNavBar() {
        let image = UIImageView(image: UIImage(named: "marvelBar"))
        image.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        image.contentMode = .scaleAspectFit
        navigationItem.titleView = image
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }
    
}
