//
//  myTableViewCell.swift
//  DogsApp
//
//  Created by Bedirhan Köse on 07.01.23.
//

import UIKit

class myTableViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
