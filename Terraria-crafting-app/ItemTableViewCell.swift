//
//  ItemTableViewCell.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-22.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = TerrariaWhite
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
