//
//  VivoTableViewCell.swift
//  VivoFinder
//
//  Created by developersancho on 2.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

class VivoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoView: UIView!
    
    let primaryDark = UIColor().colorFromHex("7B1616")
    let primary = UIColor().colorFromHex("8F2121")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        logoView.backgroundColor = primary
        logoView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
