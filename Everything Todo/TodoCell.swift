//
//  TodoCell.swift
//  Everything Todo
//
//  Created by Akash Giri on 26/07/19.
//  Copyright © 2019 Akash Giri. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    
    var isChecked = false
    
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
