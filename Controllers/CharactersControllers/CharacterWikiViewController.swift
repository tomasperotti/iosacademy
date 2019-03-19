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
        heroWikiWebView.uiDelegate = self
        heroWikiWebView.navigationDelegate = self
        renderWebView ()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeHeroWikiModalView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func renderWebView () {
        
        // MARK: TOFIX - render web view
        
        if  hero?.urls != nil {
            
            let exists = hero!.urls.contains { $0.realType == .wiki }
            
            if exists {
                
                let url = hero?.urls.filter({ return $0.realType == .wiki }).first!.url
                
                if let url = url {
                    
                    let urlWikiStringWithKey = url + MarvelAPIKeysHandler.PUBLIC_PRIVATE_KEY
                    
                    if let urlForWebView = URL(string: urlWikiStringWithKey.replacingOccurrences(of: "http", with: "https")) {

                            let requestURLForWebView = URLRequest(url: urlForWebView)
                            heroWikiWebView.load(requestURLForWebView)
                        
                    }
                    
                }
                
            }

            
        } else {
            closeButton.backgroundColor = UIColor.black
            closeButton.setTitle("No info, please close", for: UIControl.State.normal)
        }
        
    }

    
}

extension CharacterWikiViewController : WKUIDelegate, WKNavigationDelegate {
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
  
}
