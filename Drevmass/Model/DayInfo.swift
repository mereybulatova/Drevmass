//
//  AllUserInformation.swift
//  Drevmass
//
//  Created by Мерей Булатова on 29.11.2023.
//

import Foundation
import SwiftyJSON

struct Day {
    var id: Int = 0
    var monday: Int = 0
    var tuesday: Int = 0
    var wednesday: Int = 0
    var thursday: Int = 0
    var friday: Int = 0
    var saturday: Int = 0
    var sunday: Int = 0
    var time: String = ""

    init() {}

    init(json: JSON) {
        monday = json ["day"]["monday"].intValue
        tuesday = json ["day"]["tuesday"].intValue
        wednesday = json ["day"]["wednesday"].intValue
        thursday = json ["day"]["thursday"].intValue
        friday = json ["day"]["friday"].intValue
        saturday = json ["day"]["saturday"].intValue
        sunday = json ["day"]["sunday"].intValue
        time = json["day"]["time"].stringValue
    }
}
