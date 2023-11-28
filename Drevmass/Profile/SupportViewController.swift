//
//  SupportViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit

class SupportViewController: UIViewController {
    
    private lazy var supportTextField: UITextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Расскажите, что не работает?"
        textField.textColor = .appMediumGray
        textField.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        textField.borderStyle = .none
        textField.textAlignment = .left
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Отправить", for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension SupportViewController {
    
    func setupViews() {
        navigationItem.title = "Служба поддержки"
    
        view.backgroundColor = .appWhite
        view.addSubviews(supportTextField, sendButton)
    }
    
    func setupConstraints() {
        
        supportTextField.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        sendButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(35)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
    }
}
