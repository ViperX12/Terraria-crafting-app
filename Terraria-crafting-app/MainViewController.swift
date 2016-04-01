//
//  ViewController.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-20.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton! {
        didSet{
            button1.layer.cornerRadius = 5
            button1.layer.borderWidth = 1
            button1.layer.backgroundColor = TerrariaGreen.CGColor
            button1.layer.borderColor = UIColor.blackColor().CGColor
            button1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
    }
    
    @IBOutlet weak var button2: UIButton! {
        didSet{
            button2.layer.cornerRadius = 5
            button2.layer.borderWidth = 1
            button2.layer.borderColor = UIColor.blackColor().CGColor
            button2.layer.backgroundColor = TerrariaGreen.CGColor
            button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = TerrariaBlue
        self.title = "Terraria Crafting Helper"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

