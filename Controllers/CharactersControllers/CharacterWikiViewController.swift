//
//  HeroWikiViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 12/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import WebKit

// MARK: TOFIX: falta linkear con coredata

class CharacterWikiViewController: UIViewController {

    var hero : Character?
    @IBOutlet weak var heroWikiWebView: WKWebView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderWebView { stop in
            stopActivityIndicator()
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeHeroWikiModalView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func renderWebView (completion: (Any?) -> Void) {
        
        startActivityIndicator()
        
        // MARK: TOFIX - render web view
        
       /* if hero?.wikiURL != "" {
            
            if let urlWikiString =  hero?.wikiURL {
                
                let urlWikiStringWithKey = urlWikiString + MarvelAPIHandler.PUBLIC_PRIVATE_KEY
            
                if let urlForWebView = URL(string: urlWikiStringWithKey.replacingOccurrences(of: "http", with: "https")) {
                
                    print(urlForWebView)
                    let requestURLForWebView = URLRequest(url: urlForWebView)
                    heroWikiWebView.load(requestURLForWebView)
                    
                }
            }
            
        } else {
            stopActivityIndicator()
            closeButton.backgroundColor = UIColor.black
            closeButton.setTitle("No info, please close", for: UIControl.State.normal)
        }*/
        
        
        
        
    }
    
    private func startActivityIndicator () {
        activityIndicatorView.center = self.view.center
        activityIndicatorView.hidesWhenStopped = true
    }
   
    private func stopActivityIndicator () {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
