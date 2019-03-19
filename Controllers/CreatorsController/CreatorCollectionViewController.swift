//
//  CreatorCollectionViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import SDWebImage

class CreatorCollectionViewController: UIViewController {
    
    @IBOutlet weak var creatorCollectionView: UICollectionView!
    var creatorList : [Creator] = []
    var creator: Creator?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting layout for collection view
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize (width: (self.creatorCollectionView.frame.size.width - 20)/2, height: (self.creatorCollectionView.frame.size.height)/3)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        self.creatorCollectionView.collectionViewLayout = layout
        
        CreatorManager.getCreatorsFromAPI(completion: { (creatorList) in
            self.creatorList = creatorList
            self.creatorCollectionView.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // MARK: TODO: Implementar segue al detail de creator
       /* if let destinationView = segue.destination as? CreatorDetailViewController {
            
            if let s = sender as? CreatorCollectionViewCell {
                if let index = creatorCollectionView.indexPath(for: s)?.row {
                    
                    // destinationView.creator = creatorList[index]
                }
            }
            
        }*/
        
    }

}

extension CreatorCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creatorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "creatorCell", for: indexPath) as! CreatorCollectionViewCell
        
        let newCreator = creatorList[indexPath.row]
        
        if let creatorImageURL = newCreator.image {
            cell.creatorImageView.sd_setImage(with:  URL(string: creatorImageURL.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
        }
        cell.creatorNameLabel.text = newCreator.name
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.yellow.cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
        
    }
    
    
    
}
