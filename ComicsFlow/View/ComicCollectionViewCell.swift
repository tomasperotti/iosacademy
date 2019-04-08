//
//  ComicCollectionViewCell.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ComicCollectionViewCell : UICollectionViewCell {

    @IBOutlet weak var comicImageView : UIImageView!
    
//    var comicViewModel: ComicViewModelProtocol! {
//        didSet {
//
//            // MARK: -TOFIX: fix image
//
//           /*if let uURL = comicViewModel.imageURL {
//                self.comicImageView?.sd_setImage(with: uURL, placeholderImage: UIImage(named: "deadpool"), options: nil, completed: nil)
//            }*/
//
//            comicImageView.image = UIImage(named: "deadpool")
//
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
    }

}
