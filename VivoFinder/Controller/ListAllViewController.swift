//
//  ListAllViewController.swift
//  VivoFinder
//
//  Created by developersancho on 30.05.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListAllViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vivoData: [VivoModel] = []
    var basePathUrl = "http://api.developersancho.com/v1/vivos/all/distance/1000"
    let coordinate: (lat: Double, long: Double) = (41.013930, 28.983576)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.estimatedRowHeight = 88
        self.tableView.register(UINib(nibName: "VivoTableViewCell", bundle: nil), forCellReuseIdentifier: "vivoCell")
        
        let myLat = String(coordinate.lat).replace(target: ".", withString: ",")
        let myLng = String(coordinate.long).replace(target: ".", withString: ",")
        
        fetchVivoData(latitude: myLat, longitude: myLng)
    }
    
    func setupNavBar(){
        let icon = UIImage(named: "left")
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        let iconButton = UIButton(frame: iconSize)
        iconButton.setBackgroundImage(icon, for: .normal)
        let barButton = UIBarButtonItem(customView: iconButton)
        navigationItem.leftBarButtonItem = barButton
        iconButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let width = barButton.customView?.widthAnchor.constraint(equalToConstant: 30)
        width?.isActive = true
        let height = barButton.customView?.heightAnchor.constraint(equalToConstant: 30)
        height?.isActive = true
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kategoriler", style: .done, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
    }
    
    @objc func goBack(){
        switchToViewController(identifier: "homeViewController")
    }
    
    func switchToViewController(identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.setViewControllers([viewController!], animated: false)
    }
    
    func fetchVivoData(latitude: String, longitude: String) {
        if let vivoURL = URL(string: "\(basePathUrl)/\(latitude)/\(longitude)") {
            print(vivoURL)
            DispatchQueue.main.async {
                Alamofire.request(vivoURL).validate().responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print(json)
                        json.array?.forEach({ (vivo) in
                            let vivoModel = VivoModel(id: vivo["Id"].intValue, address: vivo["Address"].stringValue, brand: vivo["Brand"].stringValue, city: vivo["City"].stringValue, code: vivo["Code"].stringValue, name: vivo["Name"].stringValue, neighborhood: vivo["Neighborhood"].stringValue, postcode: vivo["Postcode"].stringValue, town: vivo["Town"].stringValue, type: vivo["Type"].stringValue, xCoor: vivo["XCoor"].doubleValue, yCoor: vivo["YCoor"].doubleValue, distance: vivo["Distance"].doubleValue)
                            
                            self.vivoData.append(vivoModel)
                        })
                        self.vivoData = self.vivoData.sorted(by: { (vivo1: VivoModel, vivo2: VivoModel) -> Bool in return (vivo1.distance ?? 0.0) < (vivo2.distance ?? 0.0) })
                       
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        }
    }
    
}

extension ListAllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vivoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vivoCell", for: indexPath) as! VivoTableViewCell
        
        cell.nameLabel.text = vivoData[indexPath.row].name
        cell.typeLabel.text = vivoData[indexPath.row].type
        cell.distanceLabel.text = vivoData[indexPath.row].distance?.toString()
        
        return cell
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}

extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

