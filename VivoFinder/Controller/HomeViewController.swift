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
    
    var panel:SlidingUpPanel!
    var locationManager = CLLocationManager()
    
    let map : MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
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
        addMap()
        addPanel()
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
    
    
    
    
    func addPanel(){
        panel = SlidingUpPanel(frame: self.view.bounds);
        
        if #available(iOS 11.0, *) {
            panel.backgroundColor = UIColor(named: "ColorPrimary")
        } else {
            panel.backgroundColor = UIColor(displayP3Red: 143/255, green: 33/255, blue:33/255 , alpha: 1)
        }
        var frame = self.view.bounds
        frame.size.height = 80.0
        let bar = UIView(frame: frame);
        if #available(iOS 11.0, *) {
            bar.backgroundColor  = UIColor(named: "ColorPrimaryDark")
        } else {
            bar.backgroundColor = UIColor(displayP3Red: 143/255, green: 33/255, blue:33/255 , alpha: 1)
        }
        
        let btnBar = UIButton(frame: CGRect(x: (bar.frame.size.width - 240) / 2, y: (bar.frame.size.height - 40) / 2, width :240, height :40))
        
        btnBar.backgroundColor = .clear
        btnBar.setTitle("Yakınımda Ne Var?", for: .normal)
        btnBar.layer.cornerRadius = 20
        btnBar.layer.borderWidth = 2
        btnBar.layer.borderColor = UIColor.white.cgColor
        btnBar.addTarget(self, action: #selector(HomeViewController.greatBar), for: .touchUpInside)
        bar.addSubview(btnBar)
        
        panel.topView = bar;
        
        let tooltip = UIView(frame: frame);
        
        if #available(iOS 11.0, *) {
            tooltip.backgroundColor = UIColor(named: "ColorPrimary")
        } else {
            tooltip.backgroundColor = UIColor(displayP3Red: 143/255, green: 33/255, blue:33/255 , alpha: 1)
        }
        //let btn = UIButton(frame: CGRect(x: 320.0 - 220.0, y: 20, width :200, height :40))
        let btn = UIButton(frame: CGRect(x: (tooltip.frame.size.width - 240) / 2, y: (tooltip.frame.size.height - 40) / 2, width :240, height :40))
        
        btn.backgroundColor = .clear
        btn.setTitle("Yakınımda Ne Var?", for: .normal)
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        //btn.center = self.panel.center
        
        btn.addTarget(self, action: #selector(HomeViewController.great), for: .touchUpInside)
        tooltip.addSubview(btn)
        
        panel.tooltip = tooltip
        
        
        self.view.addSubview(panel)
    }
    
    func addMap(){
        self.view.addSubview(map)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: map)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: map)
        //let largeMapInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
    }
    
    @objc func great(){
        
    }
    
    @objc func greatBar(){
        print("great BAR")
    }
    
    
    /*
     override func viewWillAppear(_ animated: Bool) {
     let nav = self.navigationController?.navigationBar
     nav?.barStyle = UIBarStyle.black
     nav?.isTranslucent = false
     nav?.tintColor = UIColor.white
     nav?.barTintColor = UIColor(named: "ColorPrimary")
     nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
     }
     */
    
}

