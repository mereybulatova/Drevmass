//
//  Subviews + Extensions.swift
//  Drevmass
//
//  Created by Мерей Булатова on 22.11.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

