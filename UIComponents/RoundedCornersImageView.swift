//
//  RoundedImageView.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 20/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit

class RoundedCornersImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.black.cgColor
        clipsToBounds = true
        layer.borderWidth = 3

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
    
}
