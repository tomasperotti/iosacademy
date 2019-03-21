//
//  AppDelegate.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 27/02/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

enum TabNames: String {
    
    case characters
    case comics
    case creators
    case maps
    case unknown
    
    func getIndex() -> Int {
        
        switch self {
            
        case .characters :
            return 0
        case .comics :
            return 1
        case .creators :
            return 2
        case .maps :
            return 3
        default:
            return -1
        }
    }
    
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(20)
        
        // Step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.saveContext()
        
        
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        if let scheme = url.scheme, scheme.localizedCaseInsensitiveCompare("superheroes") == .orderedSame, let appSection = url.host, let tabEnum = TabNames(rawValue: appSection.lowercased()) {
            
            
            let index = tabEnum.getIndex()
            
            if index != -1 {
                // User selected Tab exists
                
                if let root = self.window?.rootViewController as? TabBarViewController {
                    root.selectedIndex = index
                    return true
                }

            } else {
                
                 // User input is not valid
                
                let alertController = UIAlertController(title: "Select a valid URL", message: "You have to select a valid URL. Like Characters, Comics, Maps or Creators.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(okAction)
                window?.rootViewController?.present(alertController, animated: true, completion: nil)
                return false
               
            }
 
        }
        
        return false
        
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        guard let root = self.window?.rootViewController as? TabBarViewController, let current = root.viewControllers?[root.selectedIndex] as? UINavigationController, let currentRefreshableController = current.topViewController as? CanBeRefreshed else {
            
            print("FETCH BACK ::: Application NOT refreshed!!")
            completionHandler(.failed)
            return
            
        }
            
        DispatchQueue.main.async {
            currentRefreshableController.refresh()
            print("FETCH BACK ::: Application Refreshed!!")
            completionHandler(.newData)
        }

    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

