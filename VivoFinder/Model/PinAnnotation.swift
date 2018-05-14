//
//  PinAnnotation.swift
//  VivoFinder
//
//  Created by developersancho on 13.05.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit
import MapKit

class PinAnnotation: NSObject , MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    init(title:String, subtitle:String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
