//
//  MapViewController.swift
//  VivoFinder
//
//  Created by developersancho on 12.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import MapKit
import AppBottomActionSheet

class MapViewController: UIViewController, MKMapViewDelegate, HalfSheetPresentingProtocol {
    
    var transitionManager: HalfSheetPresentationManager!
    @IBOutlet weak var mapVivo: MKMapView!
    var vivoData: [VivoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVivo.delegate = self
        let sv = UIViewController.displaySpinner(onView: self.view)
        for vivo in vivoData {
            pinVivo(vivo: vivo)
        }
        UIViewController.removeSpinner(spinner: sv)
        
    }
    
    fileprivate func pinVivo(vivo: VivoModel) {
        let lat = vivo.xCoor
        let lng = vivo.yCoor
        
        let myPin = CLLocationCoordinate2D(latitude: Double(lat!), longitude: Double(lng!))
        mapVivo.setRegion(MKCoordinateRegionMakeWithDistance(myPin, 1000, 1000), animated: true)
        
        let pin = PinAnnotation(code:(vivo.code)! ,title: (vivo.name)!, subtitle: (vivo.brand)!, coordinate: myPin)
        mapVivo.addAnnotation(pin)
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
        let location = view.annotation as! PinAnnotation
        for venue in vivoData {
            if location.code == venue.code {
                Common.myVivo = VivoModel(id: venue.id, address: venue.address, brand: venue.brand, city: venue.city, code: venue.code, name: venue.name, neighborhood: venue.neighborhood, postcode: venue.postcode, town: venue.town, type: venue.type, xCoor: venue.xCoor, yCoor: venue.yCoor, distance: venue.distance)
            }
        }

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bottomDetailViewController") as! BottomDetailViewController
        presentUsingHalfSheet(vc)
    }
    
}
