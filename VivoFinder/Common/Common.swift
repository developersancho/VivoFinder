//
//  Common.swift
//  VivoFinder
//
//  Created by developersancho on 10.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Common {
    static let OTOPARK:String = "OTOPARK"
    static let TRANSPORT:String = "ULAŞIM"
    static let AKBIL:String = "AKBIL"
    static let AVM:String = "AVM"
    static let ATM:String = "ATM"
    static let BANK:String = "BANKA"
    static let BENZIN:String = "BENZIN"
    static let CHARGEVEHICLE = "ARAÇ ŞARJ"
    static let CINEMA:String = "SINEMA"
    static let INSPECTION:String = "ARAÇ MUAYENE"
    static let ISBIKE:String = "ISBIKE"
    static let MARKET:String = "MARKET"
    
    static let primaryDark = UIColor().colorFromHex("7B1616")
    static let primary = UIColor().colorFromHex("8F2121")
    static let gray = UIColor().colorFromHex("fbfbfb")
    static var vivoLocation = CLLocation()
    static var myVivo:VivoModel?
}

class TYPE {
    static let OTOPARK:String = "OTOPARK"
    static let TRANSPORT:String = "TRANSPORT"
    static let AKBIL:String = "AKBIL"
    static let AVM:String = "AVM"
    static let ATM:String = "ATM"
    static let BANK:String = "BANK"
    static let BENZIN:String = "BENZIN"
    static let CHARGEVEHICLE = "CHARGEVEHICLE"
    static let CINEMA:String = "CINEMA"
    static let INSPECTION:String = "INSPECTION"
    static let ISBIKE:String = "ISBIKE"
    static let MARKET:String = "MARKET"
}
