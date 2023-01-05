//
//  MyCollectionViewCell.swift
//  DogApp
//
//  Created by Bedirhan Köse on 03.01.23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }
}
