//
//  AboutViewController.swift
//  VivoFinder
//
//  Created by developersancho on 12.05.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//
import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setupNavBar(){
        view.backgroundColor = UIColor.white
        title = "HAKKIMIZDA"
        
        let icon = UIImage(named: "menu")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        navigationItem.leftBarButtonItem = barButton
        iconButton.addTarget(self, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        let width = barButton.customView?.widthAnchor.constraint(equalToConstant: 30)
        width?.isActive = true
        let height = barButton.customView?.heightAnchor.constraint(equalToConstant: 30)
        height?.isActive = true
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .done, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
    }
    
}
