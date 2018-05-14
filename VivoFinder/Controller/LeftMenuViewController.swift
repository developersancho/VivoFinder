//
//  LeftMenuViewController.swift
//  VivoFinder
//
//  Created by developersancho on 12.05.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//
import Foundation
import UIKit

class LeftMenuViewController: UIViewController {

    let titles: [String] = ["ANASAYFA", "BİLGİLENDİRME", "HAKKIMIZDA"]
    
    let images: [String] = ["IconHome", "IconInfo", "IconAbout"]
    
    var controllers = ["homeViewController", "infoViewController", "aboutViewController"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: 20, y: (self.view.frame.size.height - 54 * 5) / 2.0, width: self.view.frame.size.width, height: 54 * 5)
        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK : TableViewDataSource & Delegate Methods

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "Futura", size: 20)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .none
        cell.imageView?.image = UIImage(named: images[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath as NSIndexPath).row < controllers.count {
            let controllerName: String = controllers[(indexPath as NSIndexPath).row]
            
            var controller: UIViewController?
            
            controller = self.storyboard?.instantiateViewController(withIdentifier: controllerName)
            
            
            if controller != nil {
                self.sideMenuViewController?.contentViewController = UINavigationController(rootViewController: controller!)
            }
        }
        self.sideMenuViewController?.hideMenuViewController()
        
        
        /*
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: HomeViewController())
            sideMenuViewController?.hideMenuViewController()
            break
        case 1:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: InfoViewController())
            sideMenuViewController?.hideMenuViewController()
            break
        case 2:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: AboutViewController())
            sideMenuViewController?.hideMenuViewController()
            break
        default:
            break
        }
        */
        
    }
    
}
