//
//  Items.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-22.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import Foundation
import CoreData

class Items: NSManagedObject {
    @NSManaged var name:String?
    @NSManaged var craftingRecipe:String?
}