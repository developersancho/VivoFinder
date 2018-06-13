//
//  PinAnnotation.swift
//  VivoFinder
//
//  Created by developersancho on 13.05.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class PinAnnotation: NSObject, MKAnnotation {
    var code: String?
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(code:String, title:String, subtitle:String, coordinate: CLLocationCoordinate2D) {
        self.code = code
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    

    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
