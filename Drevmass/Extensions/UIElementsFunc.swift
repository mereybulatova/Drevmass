//
//  UIElementsFunc.swift
//  Drevmass
//
//  Created by Мерей Булатова on 25.11.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func createTextField(placeholder: String, secureText: Bool) -> UITextField {
        let textField = TextFieldWithPadding()
        textField.placeholder = placeholder
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        textField.textColor = .appMediumGray
        textField.isSecureTextEntry = secureText
        textField.borderStyle = .none
        return textField
    }
    
    public func createProfileButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appBrown, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        return button
    }
    
    public func createImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }
    
    public func createBeigeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .appBeige
        return view
    }
    
    public func createLightGrayView() -> UIView {
        let view = UIView()
        view.backgroundColor = .appLightGray
        return view
    }
    
    public func createLightLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }
}
