//
//  CharacterCell.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 28/02/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit

protocol CharacterCellDelegate : class {
    func tapScheduleButton (tag: Int)
}

class CharacterCell: UITableViewCell {
    
    weak var delegate : CharacterCellDelegate?

    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroCellImageView: UIImageView!
    @IBOutlet weak var scheduleButton: UIButton!

    func roundHeroCellImageView () {
        heroCellImageView.layer.cornerRadius = heroCellImageView.frame.size.width / 2
        heroCellImageView.clipsToBounds = true
    }
    
    @IBAction func scheduleNotification(_ sender: Any) {
        self.delegate?.tapScheduleButton(tag: scheduleButton.tag)
    }
    
}


