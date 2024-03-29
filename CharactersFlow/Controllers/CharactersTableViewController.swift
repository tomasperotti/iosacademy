//
//  RootViewController.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 27/02/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import SwiftHash
import SwiftyJSON
import Foundation
import SDWebImage
import UserNotifications


class CharactersTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var heroTableView: UITableView!
    var searchController : UISearchController?
    var arrayHeroes : [Character] = []
    var filteredSuperheroes : [Character] = []
    let managerSuperhero = CharacterManager()
    var dateFromPicker : Date?
    var intervalSelectedByUser : Double?
    var indexFromHeroToSchedule : Int?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredSuperheroes.count
        }
        return arrayHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = heroTableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! CharacterCell
        let hero: Character
        if isFiltering() {
            hero = filteredSuperheroes[indexPath.row]
        } else {
            hero = arrayHeroes[indexPath.row]
        }
        cell.heroNameLabel.text = hero.name
        cell.delegate = self
        cell.scheduleButton.tag = indexPath.row

        // Setting ImageVIew
        let image = hero.thumbnail.path + "." + hero.thumbnail.ext

        if image != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg" {
             cell.heroCellImageView.sd_setImage(with:  URL(string: image.replacingOccurrences(of: "http", with: "https")), placeholderImage: nil, options: [], completed: nil)
            
        } else {
            cell.heroCellImageView.image = UIImage(named: "death")
        }

        return cell
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        setupNavBar()
        updateDataFromTableView()
        

    }
    
    func updateDataFromTableView () {
        
        managerSuperhero.getHeroes { [weak self] (characterList) in
            
            guard let uSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                uSelf.arrayHeroes = characterList
                uSelf.heroTableView.reloadData()
            }
            
        }
        
    }
    
    func setupNavBar() {
        let image = UIImageView(image: UIImage(named: "marvelBar"))
        image.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        image.contentMode = .scaleAspectFit
        navigationItem.titleView = image
        navigationController?.navigationBar.prefersLargeTitles = false
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.backgroundColor = UIColor.white
        searchController?.searchBar.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        searchController?.searchBar.placeholder = "Search superheroes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if let view = segue.destination as? CharactersDetailViewController {
            
            if let s = sender as? CharacterCell {
                
                if let index = heroTableView.indexPath(for: s)?.row {
                    if (isFiltering()) {
                        view.hero = filteredSuperheroes[index]
                    } else {
                        view.hero = arrayHeroes[index]
                    }
                    
                }

            }
            
        }
    
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController?.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        

        CharacterManager().searchSuperheroes(nameWith: searchText) { (fSuperheroes, success, message) in
            if (success == true) {
                self.filteredSuperheroes = fSuperheroes ?? []
            } else {
                // MARK: TODO: Setear alguna label con no results
            }
        }
        DispatchQueue.main.async {
            self.heroTableView.reloadData()
        }
        
    }
    
    func isFiltering() -> Bool {
	        let salida = (searchController?.isActive)! && !searchBarIsEmpty()
        if (salida) {
            return salida
        } else {
            return false
        }
      
    }
    
}

extension CharactersTableViewController : UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}

extension CharactersTableViewController : CharacterCellDelegate {
    
    
    func tapScheduleButton(tag: Int) {
        self.indexFromHeroToSchedule = tag
        scheduleDetail()
    }
    
    func scheduleDetail() {
        // Creating Action Sheet
        showActionSheet()
    }
    
    // MARK: -REFACTOR: Separate this logic
    // MARK: -TODO: Implement notificacion on tap to go to superhero detail
    
    func calculateNotification () {
        
        // Create the notification content
        if intervalSelectedByUser != nil || dateFromPicker != nil {
            
            // Create the notification title and body
            let content = UNMutableNotificationContent()
            content.title = "Hey it's time to see your superhero \(self.arrayHeroes[indexFromHeroToSchedule!].name)!"
            content.body = "Look at me!"
            
            var dateComponents = DateComponents()
            
            switch (intervalSelectedByUser) {
            case nil:
                if (dateFromPicker != nil) {
                    dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateFromPicker!)
                    // Seteo date from picker en nulo devuelta
                    dateFromPicker = nil
                }
            case 10.0, 60.0:
                let date = Date().addingTimeInterval(intervalSelectedByUser!)
                dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                intervalSelectedByUser = nil
            default:
                dateFromPicker = nil
                intervalSelectedByUser = nil
                print("Nothing happen in date picker")
                
            }
            
            print(dateComponents)
            // Step 3: Create the notification trigger
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            // Step 4: Create the request
            
            let uuidString = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            
            // Step 5: Register the request
            UNUserNotificationCenter.current().add(request) { (error) in
                // Check the error parameter and handle any errors
                
            }
            
        } else {
            return
        }
        
    }
    
    /* Create and present the action sheet
     */
    func showActionSheet() {
        
        
        let actionSheet = UIAlertController (title: "Schedule your superhero", message: "Choose an interval or date", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "In 10 seconds", style: .default) { (action) in
            self.intervalSelectedByUser = 10.0
            self.calculateNotification()
        })
        
        actionSheet.addAction(UIAlertAction(title: "In 60 seconds", style: .default) { (action) in
            self.intervalSelectedByUser = 60.0
            self.calculateNotification()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let actionPickDate = UIAlertAction(title: "Pick the date", style: .default) { (action) in
            // Create a date picker
            let vc = DatePickerViewController(nibName: "DatePickerViewController", bundle: nil)
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
            
        }
        
        actionSheet.addAction(actionPickDate)
        
        present(actionSheet, animated: true, completion: nil)
       
    
    }
    
   
    
    
}

extension CharactersTableViewController : DatePickerViewDelegate {

    func getDateFromDatePicker(date: Date) {
        self.dateFromPicker = date
        calculateNotification()
    }
  
}

extension CharactersTableViewController : CanBeRefreshed {
    func refresh() {
        updateDataFromTableView()
        print(arrayHeroes)
    }
}


