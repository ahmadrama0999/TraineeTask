//
//  TableViewCell.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 25.06.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
