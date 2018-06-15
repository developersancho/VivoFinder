//
//  ContentViewController.swift
//  VivoFinder
//
//  Created by developersancho on 26.05.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

class ContentMenusViewController: PullUpController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nearByBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearByBtn.layer.cornerRadius = 12
        self.willMoveToStickyPoint = { point in
            print("willMoveToStickyPoint \(point)")
        }
        
        self.didMoveToStickyPoint = { point in
            print("didMoveToStickyPoint \(point)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.cornerRadius = 30
    }
    
    @IBAction func openSlidingMenu(_ sender: Any) {
        if let lastStickyPoint = pullUpControllerAllStickyPoints.last {
            pullUpControllerMoveToVisiblePoint(lastStickyPoint, completion: nil)
        }
    }
    
    
    
    override var pullUpControllerPreferredSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: contentView.frame.maxY)
    }
    
    override var pullUpControllerPreviewOffset: CGFloat {
        return (headerView.frame.height)
    }
    
    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        return [contentView.frame.maxY]
    }
    
    override var pullUpControllerIsBouncingEnabled: Bool {
        return false
    }
    
    override var pullUpControllerPreferredLandscapeFrame: CGRect {
        return CGRect(x: 5, y: 5, width: 280, height: UIScreen.main.bounds.height - 10)
    }
}
