//
//  AppDelegate.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-20.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        preloadData()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "wlu.Terraria_crafting_app" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Terraria_crafting_app", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreDataSuper.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func parseCSV (contentsOfURL: NSURL, encoding: NSStringEncoding, error: NSErrorPointer) -> [(name:String, craftingRecipe:String, requiredTiles:String, needWater:String, needHoney:String, anyIronBar:String, anyWood:String)]? {
        
        // Load the CSV file and parse it
        let delimiter = ","
        var items:[(name:String, craftingRecipe:String, requiredTiles:String, needWater:String, needHoney:String, anyIronBar:String, anyWood:String)]?
        
        do {
            let content = try String(contentsOfURL: contentsOfURL, encoding: encoding)
            //print(content)
            items = []
            let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
            
            for line in lines {
                var values:[String] = []
                if line != "" {
                    // For a line with double quotes
                    // we use NSScanner to perform the parsing
                    
                    values = line.componentsSeparatedByString(delimiter)
                    
                    // Put the values into the tuple and add it to the items array
                    let item = (name: values[0], craftingRecipe: values[1], requiredTiles: values[2], needWater: values[3], needHoney: values[4], anyIronBar: values[5], anyWood: values[6])
                    items?.append(item)
                }
            }
            
        } catch {
            print(error)
        }
        
        return items
    }
    
    func preloadData () {
        // Retrieve data from the source file
        
        if let contentsOfURL = NSBundle.mainBundle().URLForResource("ItemDataSuper", withExtension: "csv") {
            // Remove all the menu items before preloading
            removeData()
            
            var error:NSError?
            if let items = parseCSV(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error) {
                // Preload the menu items
                let managedObjectContext = self.managedObjectContext
                    for item in items {
                        let currentItem = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: managedObjectContext) as! Items
                        currentItem.name = item.name
                        currentItem.craftingRecipe = item.craftingRecipe
                        currentItem.requiredTiles = item.requiredTiles
                        currentItem.needWater = item.needWater
                        currentItem.needHoney = item.needHoney
                        currentItem.anyIronBar = item.anyIronBar
                        currentItem.anyWood = item.anyWood

                        do {
                            try managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                
            }
        }
    }
    
    func removeData () {
        // Remove the existing items
        let managedObjectContext = self.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Items")
        
            let savedItems = try? managedObjectContext.executeFetchRequest(fetchRequest) as! [Items]
        
            for Item in savedItems! {
                managedObjectContext.deleteObject(Item)
            }
        }
        
    }



