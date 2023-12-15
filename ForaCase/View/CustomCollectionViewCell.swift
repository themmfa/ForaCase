//
//  CustomCollectionViewCell.swift
//  ForaCase
//
//  Created by F E on 14.12.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var arrowImageView: UIImageView!

    @IBOutlet weak var cellView: UIView!
    
    
    @IBOutlet weak var stockNameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var lastChangedTimeLabel: UILabel!
    
    @IBOutlet weak var lastPriceTable: UILabel!
    
    
    @IBOutlet weak var differenceLabel: UILabel!
}
