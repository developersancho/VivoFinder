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
    
    fileprivate func loadLocationPin() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
    }
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Common.myVivo = nil
    }
    
    @IBAction func openNearByClick(_ sender: Any) {
        performSegue(withIdentifier: "myLocation", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ListAllViewController
        vc.mylocation = self.myLocation
    }
    
    func switchToViewController(identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.setViewControllers([viewController!], animated: false)
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
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kategoriler", style: .done, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        
    }
    
    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            map.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private let regionRadius: CLLocationDistance = 1000 // 1km ~ 1 mile = 1.6km
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
}


