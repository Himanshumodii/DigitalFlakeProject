//
//  BookTableViewCell.swift
//  DigitalflakeProject
//
//  Created by niket verma on 09/04/24.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var deskIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bookedLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
