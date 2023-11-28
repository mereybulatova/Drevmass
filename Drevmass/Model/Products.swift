//
//  Products.swift
//  Drevmass
//
//  Created by Мерей Булатова on 27.11.2023.
//

import Foundation
import SwiftyJSON

class Products {
    public var id: Int = 0
    public var name: String = ""
    public var title: String = ""
    public var description: String = ""
    public var image_src: String = ""
    public var video_src: String = ""
    public var price: Int = 0
    public var weight: Int = 0
    public var length: String = ""
    public var height: String = ""
    public var depth: Int = 0
    public var status: Int = 0
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["title"].string {
            self.title = temp
        }
        if let temp = json["description"].string {
            self.description = temp
        }
        if let temp = json["image_src"].string {
            self.image_src = temp
        }
        if let temp = json["video_src"].string {
            self.video_src = temp
        }
        if let temp = json["price"].int {
            self.price = temp
        }
        if let temp = json["weight"].int {
            self.weight = temp
        }
        if let temp = json["length"].string {
            self.length = temp
        }
        if let temp = json["height"].string {
            self.height = temp
        }
        if let temp = json["depth"].int {
            self.depth = temp
        }
        if let temp = json["status"].int {
            self.status = temp
        }
        
    }
}
