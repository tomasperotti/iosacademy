//
//  CircleImageView.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 20/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        clipsToBounds = true
        contentMode = .scaleAspectFit

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.size.width / 2
    }
    
}
