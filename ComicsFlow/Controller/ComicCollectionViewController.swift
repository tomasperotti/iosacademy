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
    
    var comicViewModel = ComicViewModel()
    @IBOutlet weak var comicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setLayout()
        initTable()
        
    }
    
    func initTable() {
        self.comicViewModel.fetchComics { [weak self] in
            self?.comicCollectionView.reloadData()
        }
    }
    func setLayout() {
       
        // Setting layout for collection view
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize (width: (self.comicCollectionView.frame.size.width - 20)/2, height: (self.comicCollectionView.frame.size.height)/3)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        self.comicCollectionView.collectionViewLayout = layout
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationView = segue.destination as? ComicDetailViewController {
            
            if let s = sender as? ComicCollectionViewCell {
                if let index = comicCollectionView.indexPath(for: s)?.row {
                    // MARK: -TOFIX: segues
                    //destinationView.comic = comicList[index]
                }
            }
            
        }
        
    }
    
}



extension ComicCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicViewModel.getComicsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCollectionViewCell

        if let image = comicViewModel.getImage(index: indexPath.row), image != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg" {
            cell.comicImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
        } else {
            cell.comicImageView.image = UIImage(named: "deadpool")
        }
        
      
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

extension ComicCollectionViewController : CanBeRefreshed {
   
    func refresh() {
        comicViewModel.fetchComics { [weak self] in
            
            self?.comicCollectionView.reloadData()
            
        }
    }
    
}
