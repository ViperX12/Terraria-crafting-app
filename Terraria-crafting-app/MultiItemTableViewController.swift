//
//  MultiItemTableViewController.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-31.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit

class MultiItemTableViewController: UITableViewController {

    var items = [Items]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MultiItemTableViewCell

        // Configure the cell...
        cell.nameLabel.text = items[indexPath.row].name
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let item: Items
                item = items[indexPath.row]
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = item
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
