//
//  ContentCell.swift
//  VivoFinder
//
//  Created by developersancho on 16.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import FoldingCell

class ContentMenuCell : FoldingCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var typeHeaderLabel: UILabel!
    @IBOutlet weak var distanceHeaderLabel: UILabel!
    
    @IBOutlet weak var logoContentImageView: UIImageView!
    @IBOutlet weak var typeContentLabel: UILabel!
    @IBOutlet weak var distanceContentLabel: UILabel!
    @IBOutlet weak var titleContentLabel: UILabel!
    @IBOutlet weak var adressContentText: UITextView!
    
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}
