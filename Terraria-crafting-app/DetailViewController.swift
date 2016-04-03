//
//  DetailViewController.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-26.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var csLabel: UILabel!
    @IBOutlet weak var waterInfoLabel: UILabel!
    @IBOutlet weak var honeyInfoLabel: UILabel!
    
    var detailItem : Items!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.s
        self.title = detailItem.name
        self.view.backgroundColor = TerrariaWhite
        
        recipeLabel.text = detailItem.craftingRecipe!
        recipeLabel.numberOfLines = 0
        recipeLabel.adjustsFontSizeToFitWidth = true
        
        if (detailItem.requiredTiles != ""){
            csLabel.text = detailItem.requiredTiles
        }
        else {
            csLabel.text = "No station required"
        }
        waterInfoLabel.text = detailItem.needWater
        honeyInfoLabel.text = detailItem.needHoney
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
