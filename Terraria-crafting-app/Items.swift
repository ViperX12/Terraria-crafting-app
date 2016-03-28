//
//  Items.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-22.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import Foundation
import CoreData

@objc
class Items: NSManagedObject {
    @NSManaged var name:String?
    @NSManaged var craftingRecipe:String?
    @NSManaged var requiredTiles:String?
    @NSManaged var needWater:String?
    @NSManaged var needHoney:String?
    @NSManaged var anyIronBar:String?
    @NSManaged var anyWood:String?
}