//
//  VivoModel.swift
//  VivoFinder
//
//  Created by developersancho on 2.06.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import Foundation

struct VivoModel: Codable {
    let id: Int?
    let address, brand, city, code: String?
    let name, neighborhood, postcode, town: String?
    let type: String?
    let xCoor, yCoor, distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case address = "Address"
        case brand = "Brand"
        case city = "City"
        case code = "Code"
        case name = "Name"
        case neighborhood = "Neighborhood"
        case postcode = "Postcode"
        case town = "Town"
        case type = "Type"
        case xCoor = "XCoor"
        case yCoor = "YCoor"
        case distance = "Distance"
    }
    
}
