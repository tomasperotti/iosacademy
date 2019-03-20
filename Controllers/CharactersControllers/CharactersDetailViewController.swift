//
//  ViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 27/02/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import AVKit
import SDWebImage

class CharactersDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var hero : Character!
    var string : Any?
    var comicListFromHero : [Comic] = []
    
    @IBOutlet weak var heroCollectionView: UICollectionView!
    @IBOutlet weak var heroIDLabel: UILabel!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescLabel: UILabel!
    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet weak var seeTrailerButton: UIButton!
    @IBOutlet weak var goToWikiButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCharacterDetailLayout()
        getComicsAndDisplayThem()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setCharacterDetailLayout () {
       
        heroNameLabel.text = hero.name
        heroIDLabel.text = String(hero.id)
        heroDescLabel.text = hero.heroDescription
        
        let image = hero.thumbnail.path + "." + hero.thumbnail.ext
        
        heroImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
          
    }
    
    private func getComicsAndDisplayThem () {
        
        
        ComicManager.getComicsFromAPI(heroID: hero.id) { [weak self ] (comicList) in
            
            guard let uSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                uSelf.comicListFromHero = comicList
                uSelf.heroCollectionView.reloadData()
            }
            
        }

    }
    
    @IBAction func goToWiki(_ sender: Any) {
        
    }
    
    @IBAction func seeTrailerVideo(_ sender: Any) {
        
        guard let url = Bundle.main.path(forResource: "video", ofType: "mp4") else {
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        
      
        let controller = AVPlayerViewController()
        controller.player = player
        
        present(controller, animated: true) {
            player.play()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if let dest = segue.destination as? CharactersModalViewController {
            
            dest.imageHeroView = heroImageView.image
            
        } else {
          
            if let dest = segue.destination as? CharactersComicDetailViewController {
                
                if let s = sender as? CharacterCollectionViewCell {

                    if let index = heroCollectionView.indexPath(for: s)?.row {
                       dest.heroComic = comicListFromHero[index]
                    }
                    
                }
            }
            else {
                    if let dest = segue.destination as? CharacterWikiViewController {
                        dest.hero = self.hero
                    }
            }
                
        }
        
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return comicListFromHero.count
   
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = heroCollectionView.dequeueReusableCell(withReuseIdentifier: "heroCollectionCell", for: indexPath) as! CharacterCollectionViewCell
        let image = comicListFromHero[indexPath.row].thumbnail.path + "." + comicListFromHero[indexPath.row].thumbnail.ext
        
        cell.comicCollectionImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
        
        return cell
        
    }
    
}

extension CharactersDetailViewController : CanBeRefreshed {
    
    func refresh() {
        getComicsAndDisplayThem()
    }
    
}

