//
//  ComicCollectionViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 13/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import SDWebImage

class ComicCollectionViewController: UIViewController {
    
    
    @IBOutlet weak var comicCollectionView: UICollectionView!
    var comicList : [Comic] = []
    var comic : Comic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Setting layout for collection view
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize (width: (self.comicCollectionView.frame.size.width - 20)/2, height: (self.comicCollectionView.frame.size.height)/3)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        self.comicCollectionView.collectionViewLayout = layout

        ComicManager.getComicsFromAPI(completion: { (comicList) in
     
            self.comicList = comicList
            self.comicCollectionView.reloadData()
            
        })
   
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationView = segue.destination as? TabComicDetailViewController {
            
            if let s = sender as? ComicCollectionViewCell {
                if let index = comicCollectionView.indexPath(for: s)?.row {
                    destinationView.comic = comicList[index]
                }
            }
            
        }
        
    }
    
    

}

extension ComicCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCollectionViewCell
        
        let newComic = comicList[indexPath.row]

        let image = newComic.thumbnail.path + "." + newComic.thumbnail.ext
        
        cell.comicImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
          
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
