//
//  ListMapViewController.swift
//  VivoFinder
//
//  Created by developersancho on 12.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AppBottomActionSheet

class ListMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, HalfSheetPresentingProtocol {
    
    var transitionManager: HalfSheetPresentationManager!
    @IBOutlet weak var mapDetail: MKMapView!
    var locationManager = CLLocationManager()
    var vivo : VivoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapDetail.delegate = self
        navigationItem.title = vivo?.name
        pinVivo()
        Common.myVivo = vivo
    }
    
    fileprivate func pinVivo() {
        let lat = vivo?.xCoor
        let lng = vivo?.yCoor
        
        let myPin = CLLocationCoordinate2D(latitude: Double(lat!), longitude: Double(lng!))
        mapDetail.setRegion(MKCoordinateRegionMakeWithDistance(myPin, 500, 500), animated: true)
        
        let pin = PinAnnotation(code:(vivo?.code)! ,title: (vivo?.name)!, subtitle: (vivo?.brand)!, coordinate: myPin)
        mapDetail.addAnnotation(pin)
        mapDetail.showAnnotations([pin], animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PinAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            
            return view
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        //let location = view.annotation as! PinAnnotation
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bottomDetailViewController") as! BottomDetailViewController
        presentUsingHalfSheet(vc)
        
        
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}
