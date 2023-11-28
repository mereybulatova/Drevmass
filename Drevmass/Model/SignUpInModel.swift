//
//  SignInModel.swift
//  Drevmass
//
//  Created by Мерей Булатова on 28.11.2023.
//

import Foundation

struct SignUpInModel: Decodable {
    let user: [User]
    let token_type: String
    let access_token: String
    
    struct User: Decodable {
        let name: String
        let email: String
        let id: Int
    }
}
