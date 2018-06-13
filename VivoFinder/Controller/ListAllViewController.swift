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
import CoreLocation

class ListAllViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var vivoData: [VivoModel] = []
    var basePathUrl = "http://api.developersancho.com/v1/vivos/all/distance/1000"
    let coordinate: (lat: Double, long: Double) = (41.013930, 28.983576)
    private let refreshControl = UIRefreshControl()
    var mylocation = CLLocation()
    
    
    fileprivate func RefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = UIColor.orange
        //refreshControl.backgroundColor = Common.primary
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh");
        refreshControl.addTarget(self, action: #selector(refreshVivosData(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupNavBar()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //Common.myVivo = nil
        RefreshControl()

        //self.tableView.refreshControl = UIRefreshControl()
        //self.tableView.estimatedRowHeight = 88
        self.tableView.register(UINib(nibName: "VivoTableViewCell", bundle: nil), forCellReuseIdentifier: "vivoCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        //let myLat = String(coordinate.lat).replace(target: ".", withString: ",")
        //let myLng = String(coordinate.long).replace(target: ".", withString: ",")
        
        let myLat1 = String(mylocation.coordinate.latitude).replace(target: ".", withString: ",")
        let myLng1 = String(mylocation.coordinate.longitude).replace(target: ".", withString: ",")
        
        
        fetchVivoData(latitude: myLat1, longitude: myLng1)
    }
    
    @objc private func refreshVivosData(_ sender: Any) {
        // Fetch Vivos Data
        //let myLat = String(coordinate.lat).replace(target: ".", withString: ",")
        //let myLng = String(coordinate.long).replace(target: ".", withString: ",")
    
        let myLat1 = String(mylocation.coordinate.latitude).replace(target: ".", withString: ",")
        let myLng1 = String(mylocation.coordinate.longitude).replace(target: ".", withString: ",")
        
        fetchVivoData2(latitude: myLat1, longitude: myLng1)
    }
    
    func setupNavBar(){
        title = "VIVOFINDER"
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
        let sv = UIViewController.displaySpinner(onView: self.view)
        
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
                        UIViewController.removeSpinner(spinner: sv)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        }
    }
    
    func fetchVivoData2(latitude: String, longitude: String) {
        vivoData.removeAll()
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
                        if self.refreshControl.isRefreshing
                        {
                            self.refreshControl.endRefreshing()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.refreshControl.endRefreshing()
                    }
                })
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "masterToDetail" {
            let listMapVC = segue.destination as! ListMapViewController
            listMapVC.vivo = sender as? VivoModel
        } else if segue.identifier == "masterToMap" {
            let mapVC = segue.destination as! MapViewController
            mapVC.vivoData = vivoData
        }
    }
   
    
    
}

extension ListAllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vivoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vivoCell", for: indexPath) as! VivoTableViewCell
        if vivoData.count > 0 {
            cell.nameLabel.text = vivoData[indexPath.row].name
            //cell.typeLabel.text = vivoData[indexPath.row].type
            cell.distanceLabel.text = (vivoData[indexPath.row].distance?.toString())! + " km"
            if vivoData[indexPath.row].type == TYPE.TRANSPORT {
                cell.logoImage.image = UIImage(named: "train_filled")
                cell.typeLabel.text = Common.TRANSPORT
            } else if vivoData[indexPath.row].type == TYPE.OTOPARK {
                cell.logoImage.image = UIImage(named: "parking_filled")
                cell.typeLabel.text = Common.OTOPARK
            } else if vivoData[indexPath.row].type == TYPE.AKBIL {
                cell.logoImage.image = UIImage(named: "akbil_filled")
                cell.typeLabel.text = Common.AKBIL
            } else if vivoData[indexPath.row].type == TYPE.AVM {
                cell.logoImage.image = UIImage(named: "avm_filled")
                cell.typeLabel.text = Common.AVM
            } else if vivoData[indexPath.row].type == TYPE.ATM {
                cell.logoImage.image = UIImage(named: "atm_filled")
                cell.typeLabel.text = Common.ATM
            } else if vivoData[indexPath.row].type == TYPE.BANK {
                cell.logoImage.image = UIImage(named: "bank_filled")
                cell.typeLabel.text = Common.BANK
            } else if vivoData[indexPath.row].type == TYPE.BENZIN {
                cell.logoImage.image = UIImage(named: "gas_station_filled")
                cell.typeLabel.text = Common.BENZIN
            } else if vivoData[indexPath.row].type == TYPE.CHARGEVEHICLE {
                cell.logoImage.image = UIImage(named: "park_and_charge_filled")
                cell.typeLabel.text = Common.CHARGEVEHICLE
            } else if vivoData[indexPath.row].type == TYPE.CINEMA {
                cell.logoImage.image = UIImage(named: "movie_filled")
                cell.typeLabel.text = Common.CINEMA
            } else if vivoData[indexPath.row].type == TYPE.INSPECTION {
                cell.logoImage.image = UIImage(named: "service_filled")
                cell.typeLabel.text = Common.INSPECTION
            } else if vivoData[indexPath.row].type == TYPE.ISBIKE {
                cell.logoImage.image = UIImage(named: "isbike_filled")
                cell.typeLabel.text = Common.ISBIKE
            } else if vivoData[indexPath.row].type == TYPE.MARKET {
                cell.logoImage.image = UIImage(named: "market_filled")
                cell.typeLabel.text = Common.MARKET
            }
            
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vivo = vivoData[indexPath.row]
        performSegue(withIdentifier: "masterToDetail", sender: vivo)
    }
    
}



