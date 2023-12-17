//
//  UserInformation.swift
//  Drevmass
//
//  Created by Мерей Булатова on 28.11.2023.
//

import Foundation
import SwiftyJSON

struct UserInformation: Decodable {
    let id: Int
    let user_id: Int
    let gender: String
    let height: String
    let weight: String
    let birth: String
    let activity: String
}

struct Information {
    var id: Int = 0
    var user_id: Int = 0
    var gender: Int = 0
    var height: String = ""
    var weight: String = ""
    var birth: String = ""
    var activity: Int = 0
    
    init() {}

    init(json: JSON) {
        gender = json ["information"]["gender"].intValue
        height = json ["information"]["height"].stringValue
        weight = json ["information"]["weight"].stringValue
        birth = json ["information"]["birth"].stringValue
        activity = json ["information"]["activity"].intValue
    }
}
