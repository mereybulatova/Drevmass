//
//  NavigationController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 23.11.2023.
//

import UIKit

extension UINavigationController {
    
    func setDefaultNavigationBarAppearance() {
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "Rubik-Light", size: 18)]
        self.navigationBar.titleTextAttributes = fontAttributes as [NSAttributedString.Key : Any]
        
        self.navigationBar.titleTextAttributes?[.foregroundColor] = UIColor(red: 0.71, green: 0.639, blue: 0.502, alpha: 1)
        self.navigationBar.tintColor = .appBeige
        self.navigationItem.title = ""
    }
}
