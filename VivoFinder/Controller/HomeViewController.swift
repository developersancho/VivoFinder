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

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    /*
    let map : MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    */
    let myView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    fileprivate func loadLocationPin() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        
        let istanbul = CLLocationCoordinate2D(latitude: 41.0102645, longitude: 28.9786778)
        map.setRegion(MKCoordinateRegionMakeWithDistance(istanbul, 1500, 1500), animated: true)
        
        let pin = PinAnnotation(title: "Merkez", subtitle: "Great City", coordinate: istanbul)
        
        map.addAnnotation(pin)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        loadLocationPin()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
    }
    
    func setupNavBar(){
        view.backgroundColor = UIColor.white
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
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .done, target: self, action: #selector(SSASideMenu.presentRightMenuViewController))
        //view.addSubview(homeMap)
    }
    
}

