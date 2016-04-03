//
//  ItemTableViewController.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-22.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit
import CoreData

class ItemTableViewController: UITableViewController {

    private var itemsList:[Items] = []
    var filteredItems = [Items]()
    var fetchResultController:NSFetchedResultsController!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = TerrariaWhite
        
        // Setup search bar
        self.searchController.loadViewIfNeeded()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["By Name", "By Recipe"]
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = TerrariaWhite
        
        // Load menu items from database
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            let fetchRequest = NSFetchRequest(entityName: "Items")
            do {
                itemsList = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Items]
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        
        // Sort items alphabetically by name
        itemsList = itemsList.sort{$0.name < $1.name}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredItems.count
        }
        return itemsList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ItemTableViewCell
        
        if searchController.active && searchController.searchBar.text != "" {
            cell.NameLabel.text = filteredItems[indexPath.row].name
        }
        else {
            cell.NameLabel.text = itemsList[indexPath.row].name
        }
        
        return cell
    }
    
    // MARK: - Searching
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredItems = itemsList.filter { Items in
            if (scope == "By Recipe"){
                return Items.craftingRecipe!.lowercaseString.containsString(searchText.lowercaseString)
            }
            else {
                return Items.name!.lowercaseString.containsString(searchText.lowercaseString)
            }
        }
        
        tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let item: Items
                if searchController.active && searchController.searchBar.text != "" {
                    item = filteredItems[indexPath.row]
                } else {
                    item = itemsList[indexPath.row]
                }
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = item
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    

}

extension ItemTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension ItemTableViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
