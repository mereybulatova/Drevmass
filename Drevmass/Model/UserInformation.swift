//
//  UserInformation.swift
//  Drevmass
//
//  Created by Мерей Булатова on 28.11.2023.
//

import Foundation

struct UserInformation: Decodable {
    let id: Int
    let user_id: Int
    let gender: String
    let height: String
    let weight: String
    let birth: String
    let activity: String
}
