//
//  ViewController.swift
//  VivoFinder
//
//  Created by developersancho on 7.05.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var btnNearBy: UIButton!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var contentView: UIView!
    var locationManager = CLLocationManager()
    var myLocation = CLLocation()
    var myType: String!
    
    @IBOutlet weak var otoparkView: UIView!
    @IBOutlet weak var benzinView: UIView!
    @IBOutlet weak var vehicleChargeView: UIView!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var transportView: UIView!
    @IBOutlet weak var akbilView: UIView!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var atmView: UIView!
    @IBOutlet weak var isbikeView: UIView!
    @IBOutlet weak var cinemaView: UIView!
    @IBOutlet weak var avmView: UIView!
    @IBOutlet weak var marketView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        loadLocationPin()
        if #available(iOS 11.0, *) {
            contentView.backgroundColor = UIColor(named: "ColorPrimary")
        } else {
            contentView.backgroundColor = UIColor(displayP3Red: 143/255, green: 33/255, blue:33/255 , alpha: 1)
        }
        
        btnNearBy.layer.cornerRadius = 25
        
        
        let tapGestureOtopark = UITapGestureRecognizer(target: self, action: #selector(handleOtopark(sender:)))
        otoparkView.addGestureRecognizer(tapGestureOtopark)
        let tapGestureBenzin = UITapGestureRecognizer(target: self, action: #selector(handleBenzin(sender:)))
        benzinView.addGestureRecognizer(tapGestureBenzin)
        let tapGestureVehicleCharge = UITapGestureRecognizer(target: self, action: #selector(handleVehicleCharge(sender:)))
        vehicleChargeView.addGestureRecognizer(tapGestureVehicleCharge)
        let tapGestureService = UITapGestureRecognizer(target: self, action: #selector(handleService(sender:)))
        serviceView.addGestureRecognizer(tapGestureService)
        let tapGestureTransport = UITapGestureRecognizer(target: self, action: #selector(handleTransport(sender:)))
        transportView.addGestureRecognizer(tapGestureTransport)
        let tapGestureAkbil = UITapGestureRecognizer(target: self, action: #selector(handleAkbil(sender:)))
        akbilView.addGestureRecognizer(tapGestureAkbil)
        let tapGestureBank = UITapGestureRecognizer(target: self, action: #selector(handleBank(sender:)))
        bankView.addGestureRecognizer(tapGestureBank)
        let tapGestureAtm = UITapGestureRecognizer(target: self, action: #selector(handleAtm(sender:)))
        atmView.addGestureRecognizer(tapGestureAtm)
        let tapGestureIsbike = UITapGestureRecognizer(target: self, action: #selector(handleIsbike(sender:)))
        isbikeView.addGestureRecognizer(tapGestureIsbike)
        let tapGestureCinema = UITapGestureRecognizer(target: self, action: #selector(handleCinema(sender:)))
        cinemaView.addGestureRecognizer(tapGestureCinema)
        let tapGestureAvm = UITapGestureRecognizer(target: self, action: #selector(handleAvm(sender:)))
        avmView.addGestureRecognizer(tapGestureAvm)
        let tapGestureMarket = UITapGestureRecognizer(target: self, action: #selector(handleMarket(sender:)))
        marketView.addGestureRecognizer(tapGestureMarket)
    }
    
    @objc func handleOtopark(sender: UITapGestureRecognizer) {
        // content seque
        self.myType = Common.OTOPARK
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleBenzin(sender: UITapGestureRecognizer) {
        self.myType = Common.BENZIN
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleVehicleCharge(sender: UITapGestureRecognizer) {
        self.myType = Common.CHARGEVEHICLE
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleService(sender: UITapGestureRecognizer) {
        self.myType = Common.INSPECTION
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleTransport(sender: UITapGestureRecognizer) {
        self.myType = Common.TRANSPORT
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleAkbil(sender: UITapGestureRecognizer) {
        self.myType = Common.AKBIL
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleBank(sender: UITapGestureRecognizer) {
        self.myType = Common.BANK
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleAtm(sender: UITapGestureRecognizer) {
        self.myType = Common.ATM
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleIsbike(sender: UITapGestureRecognizer) {
        self.myType = Common.ISBIKE
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleCinema(sender: UITapGestureRecognizer) {
        self.myType = Common.CINEMA
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleAvm(sender: UITapGestureRecognizer) {
        self.myType = Common.AVM
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    @objc func handleMarket(sender: UITapGestureRecognizer) {
        self.myType = Common.MARKET
        performSegue(withIdentifier: "contentpush", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Common.myVivo = nil
    }
    
    @IBAction func openNearByClick(_ sender: Any) {
        performSegue(withIdentifier: "myLocation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myLocation" {
            let vc = segue.destination as! ListAllViewController
            vc.mylocation = self.myLocation
        } else if segue.identifier == "contentpush" {
            let vc = segue.destination as! ContentMenuTableViewController
            vc.type = self.myType
        }
        
    }
    
    func switchToViewController(identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.setViewControllers([viewController!], animated: true)
    }
    
    fileprivate func loadLocationPin() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
        myLocation = location
        Common.vivoLocation = myLocation
    }
    
    func setupNavBar(){
        title = "VIVOFINDER"
        
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
        
    }
    
}
