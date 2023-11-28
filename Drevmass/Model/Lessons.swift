//
//  Lesson.swift
//  Drevmass
//
//  Created by Мерей Булатова on 27.11.2023.
//

import Foundation
import UIKit
import SwiftyJSON

// MARK: - Lesson
class Lessons {
    public var id: Int = 0
    public var name: String = ""
    public var title: String = ""
    public var description: String = ""
    public var image_src: String = ""
    public var video_src: String = ""
    public var duration: Int = 0
    public var created_at: String = ""
    public var updated_at: String = ""
    public var favorite: Int = 0

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
        if let temp = json["duration"].int {
            self.duration = temp
        }
        if let temp = json["created_at"].string {
            self.created_at = temp
        }
        if let temp = json["updated_at"].string {
            self.updated_at = temp
        }
        if let temp = json["favorite"].int {
            self.favorite = temp
        }
    }
}
