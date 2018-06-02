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
        if #available(iOS 11.0, *) {
            contentView.backgroundColor = UIColor(named: "ColorPrimary")
        } else {
            contentView.backgroundColor = UIColor(displayP3Red: 143/255, green: 33/255, blue:33/255 , alpha: 1)
        }
        
        btnNearBy.layer.cornerRadius = 25
    }
    /*
    private func addPullUpController() {
        guard
            let pullUpController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "contentMenuViewController") as? ContentMenuViewController
            else { return }
        
        addPullUpController(pullUpController)
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    /*
    @IBAction func openNearByClick(_ sender: Any) {
        switchToViewController(identifier: "listAllViewController")
    }
 */
    
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
    
}

