//
//  UIFont + Extensions.swift
//  Drevmass
//
//  Created by Мерей Булатова on 21.11.2023.
//

import UIKit

extension UIFont {
    public enum AppFonts: String {
        case Rubik = "Rubik"
    }
    
    public enum FontWeights: String {
        case light = "Light"
        case regular = "Regular"
    }
    
    public static func appFont(
        ofSize size: CGFloat,
        weight: FontWeights = .regular,
        font: AppFonts = .Rubik
    ) -> UIFont {
        let fontName = "\(font.rawValue)-\(weight.rawValue)"

        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("Font with name \(fontName) not found!")
        }

        return font
    }
}
