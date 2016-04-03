//
//  MultiItemSearchViewController.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-31.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit
import CoreData

class MultiItemSearchViewController: UIViewController {

    @IBOutlet weak var itemInput1: UITextField!
    @IBOutlet weak var itemInput2: UITextField!
    @IBOutlet weak var itemInput3: UITextField!
    
    private var itemsList:[Items] = []
    var filteredItems = [Items]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = TerrariaBlue
        
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
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(sender: UIButton) {
        let length = itemsList.count
        var i = 0
        
        filteredItems.removeAll()
        
        var input1 = " "
        var input2 = " "
        var input3 = " "
        
        while (i < length){
            if (itemsList[i].name == itemInput1.text){
                input1 = itemInput1.text! + " "
            }
            if (itemsList[i].name == itemInput2.text){
                input2 = itemInput2.text! + " "
            }
            if (itemsList[i].name == itemInput3.text){
                input3 = itemInput3.text! + " "
            }
            i++
        }

        let inputs = [input1, input2, input3]
        
        for items in itemsList{
            if (items.craftingRecipe?.rangeOfString(inputs[0]) != nil && items.craftingRecipe?.rangeOfString(inputs[1]) != nil && items.craftingRecipe?.rangeOfString(inputs[2]) != nil){
                print(items.craftingRecipe?.rangeOfString(inputs[2]))
                filteredItems.append(items)
            }
        }
        
        if(filteredItems.count > 0){
            performSegueWithIdentifier("showTable", sender: UIButton.self)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showTable" {
            let controller: MultiItemTableViewController = segue.destinationViewController as! MultiItemTableViewController
            controller.items = filteredItems
        }
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
