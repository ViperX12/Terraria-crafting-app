//
//  MultiItemTableViewCell.swift
//  Terraria-crafting-app
//
//  Created by Giovanni on 2016-03-31.
//  Copyright © 2016 Giovanni. All rights reserved.
//

import UIKit

class MultiItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = TerrariaBlue
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
