//
//  ContentMenuTableViewController.swift
//  VivoFinder
//
//  Created by developersancho on 16.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import FoldingCell
import CoreLocation
import Alamofire
import SwiftyJSON

class ContentMenuTableViewController: UITableViewController {

    @IBOutlet var contentTableView: UITableView!
    
    var type: String!
    var mylocation = CLLocation()
    let myRefreshControl = UIRefreshControl()
    var vivoData: [VivoModel] = []
    var basePathUrl = "http://api.developersancho.com/v1/vivos/type"
    //  api.developersancho.com/v1/vivos/type
    // /OTOPARK/distance/500/41%2C008142/28%2C894688
    enum Const {
        static let closeCellHeight: CGFloat = 140
        static let openCellHeight: CGFloat = 400
    }
    
    var cellHeights: [CGFloat] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbar()
        let myLat1 = String(self.mylocation.coordinate.latitude).replace(target: ".", withString: ",")
        let myLng1 = String(self.mylocation.coordinate.longitude).replace(target: ".", withString: ",")
        
        fetchVivoData(type: getType(type: type), latitude: myLat1, longitude: myLng1)
    }
    
    func getType(type: String) -> String {
        if type == Common.AKBIL {
            return TYPE.AKBIL
        } else if type == Common.ATM {
            return TYPE.ATM
        } else if type == Common.AVM {
            return TYPE.AVM
        } else if type == Common.BANK {
            return TYPE.BANK
        } else if type == Common.BENZIN {
            return TYPE.BENZIN
        } else if type == Common.CHARGEVEHICLE {
            return TYPE.CHARGEVEHICLE
        } else if type == Common.CINEMA {
            return TYPE.CINEMA
        } else if type == Common.INSPECTION {
            return TYPE.INSPECTION
        } else if type == Common.ISBIKE {
            return TYPE.ISBIKE
        } else if type == Common.MARKET {
            return TYPE.MARKET
        } else if type == Common.OTOPARK {
            return TYPE.OTOPARK
        } else if type == Common.TRANSPORT {
            return TYPE.TRANSPORT
        }
        
        return ""
    }
    
    func fetchVivoData(type: String ,latitude: String, longitude: String) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        //  api.developersancho.com/v1/vivos/type
        // /OTOPARK/distance/500/41%2C008142/28%2C894688
        
        if let vivoURL = URL(string: "\(basePathUrl)/\(type)/distance/1000/\(latitude)/\(longitude)") {
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
                        self.setupTableView()
                        self.tableView.reloadData()
                        UIViewController.removeSpinner(spinner: sv)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
        }
    }
    
    private func setupTableView() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: vivoData.count)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = Common.gray
        tableView.separatorStyle = .none
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
        return vivoData.count
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
        
        if vivoData.count > 0 {
            cell.titleHeaderLabel.text = vivoData[indexPath.row].name
            cell.titleContentLabel.text = vivoData[indexPath.row].name
            cell.leftView.backgroundColor = UIColor.random()
            cell.distanceHeaderLabel.text = (vivoData[indexPath.row].distance?.toString())! + " km"
            cell.distanceContentLabel.text = (vivoData[indexPath.row].distance?.toString())! + " km"
            cell.adressContentText.text = vivoData[indexPath.row].address
            
            if vivoData[indexPath.row].type == TYPE.TRANSPORT {
                cell.logoImageView.image = UIImage(named: "train_filled")
                cell.typeHeaderLabel.text = Common.TRANSPORT
                cell.typeContentLabel.text = Common.TRANSPORT
                cell.logoContentImageView.image = UIImage(named: "icons8_subway")
            } else if vivoData[indexPath.row].type == TYPE.OTOPARK {
                cell.logoImageView.image = UIImage(named: "parking_filled")
                cell.typeHeaderLabel.text = Common.OTOPARK
                cell.typeContentLabel.text = Common.OTOPARK
                cell.logoContentImageView.image = UIImage(named: "icons8_parking")
            } else if vivoData[indexPath.row].type == TYPE.AKBIL {
                cell.logoImageView.image = UIImage(named: "akbil_filled")
                cell.typeHeaderLabel.text = Common.AKBIL
                cell.typeContentLabel.text = Common.AKBIL
                cell.logoContentImageView.image = UIImage(named: "icons8_akbil")
            } else if vivoData[indexPath.row].type == TYPE.AVM {
                cell.logoImageView.image = UIImage(named: "avm_filled")
                cell.typeHeaderLabel.text = Common.AVM
                cell.typeContentLabel.text = Common.AVM
                cell.logoContentImageView.image = UIImage(named: "icons8_avm")
            } else if vivoData[indexPath.row].type == TYPE.ATM {
                cell.logoImageView.image = UIImage(named: "atm_filled")
                cell.typeHeaderLabel.text = Common.ATM
                cell.typeContentLabel.text = Common.ATM
                cell.logoContentImageView.image = UIImage(named: "icons8_atm")
            } else if vivoData[indexPath.row].type == TYPE.BANK {
                cell.logoImageView.image = UIImage(named: "bank_filled")
                cell.typeHeaderLabel.text = Common.BANK
                cell.typeContentLabel.text = Common.BANK
                cell.logoContentImageView.image = UIImage(named: "icons8_bank")
            } else if vivoData[indexPath.row].type == TYPE.BENZIN {
                cell.logoImageView.image = UIImage(named: "gas_station_filled")
                cell.typeHeaderLabel.text = Common.BENZIN
                cell.typeContentLabel.text = Common.BENZIN
                cell.logoContentImageView.image = UIImage(named: "icons8_gas_station")
            } else if vivoData[indexPath.row].type == TYPE.CHARGEVEHICLE {
                cell.logoImageView.image = UIImage(named: "park_and_charge_filled")
                cell.typeHeaderLabel.text = Common.CHARGEVEHICLE
                cell.typeContentLabel.text = Common.CHARGEVEHICLE
                cell.logoContentImageView.image = UIImage(named: "icons8_park_and_charge")
            } else if vivoData[indexPath.row].type == TYPE.CINEMA {
                cell.logoImageView.image = UIImage(named: "movie_filled")
                cell.typeHeaderLabel.text = Common.CINEMA
                cell.typeContentLabel.text = Common.CINEMA
                cell.logoContentImageView.image = UIImage(named: "icons8_movie")
            } else if vivoData[indexPath.row].type == TYPE.INSPECTION {
                cell.logoImageView.image = UIImage(named: "service_filled")
                cell.typeHeaderLabel.text = Common.INSPECTION
                cell.typeContentLabel.text = Common.INSPECTION
                cell.logoContentImageView.image = UIImage(named: "icons8_service")
            } else if vivoData[indexPath.row].type == TYPE.ISBIKE {
                cell.logoImageView.image = UIImage(named: "isbike_filled")
                cell.typeHeaderLabel.text = Common.ISBIKE
                cell.typeContentLabel.text = Common.ISBIKE
                cell.logoContentImageView.image = UIImage(named: "icons8_isbike")
            } else if vivoData[indexPath.row].type == TYPE.MARKET {
                cell.logoImageView.image = UIImage(named: "market_filled")
                cell.typeHeaderLabel.text = Common.MARKET
                cell.typeContentLabel.text = Common.MARKET
                cell.logoContentImageView.image = UIImage(named: "icons8_market")
            }
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
