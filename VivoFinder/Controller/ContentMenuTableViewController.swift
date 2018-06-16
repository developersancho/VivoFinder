//
//  ContentMenuTableViewController.swift
//  VivoFinder
//
//  Created by developersancho on 16.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import FoldingCell

class ContentMenuTableViewController: UITableViewController {

    var type: String!
    
    enum Const {
        static let closeCellHeight: CGFloat = 140
        static let openCellHeight: CGFloat = 400
        static let rowsCount = 10
    }
    
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbar()
        setupTableView()
    }
    
    private func setupTableView() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = Common.primary
        tableView.separatorStyle = .none
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
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

extension ContentMenuTableViewController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }
    
    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as ContentMenuCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}
