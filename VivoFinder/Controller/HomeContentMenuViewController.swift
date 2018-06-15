//
//  ContentMenuViewController.swift
//  VivoFinder
//
//  Created by developersancho on 15.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

class HomeContentMenuViewController: UIViewController {
    
    var type: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbar()
    }
    
    func setNavbar()  {
        title = type
        let my_switch = UISwitch(frame: .zero)
        my_switch.isOn = true // or false
        my_switch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        my_switch.backgroundColor = Common.primary
        my_switch.onTintColor = UIColor.blue
        let switch_display = UIBarButtonItem(customView: my_switch)
        navigationItem.rightBarButtonItem = switch_display
        
//        let icon = UIImage(named: "left")
//        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
//        let iconButton = UIButton(frame: iconSize)
//        iconButton.setBackgroundImage(icon, for: .normal)
//        let leftBarButton = UIBarButtonItem(customView: iconButton)
//        navigationItem.leftBarButtonItem = leftBarButton
//        iconButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//        let width = leftBarButton.customView?.widthAnchor.constraint(equalToConstant: 30)
//        width?.isActive = true
//        let height = leftBarButton.customView?.heightAnchor.constraint(equalToConstant: 30)
//        height?.isActive = true
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print( "The switch is now true!" )
        }
        else{
            print( "The switch is now false!" )
        }
    }
    
    @IBAction func backAction(){
        switchToViewController(identifier: "homeViewController")
    }
    
    func switchToViewController(identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.setViewControllers([viewController!], animated: true)
    }
    
    
}
