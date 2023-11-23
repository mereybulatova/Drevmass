//
//  RestorePasswordViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 23.11.2023.
//

import UIKit

class RestorePasswordViewController: UIViewController {

    //MARK: - UI Elements
    
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .signIn
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .logoOnboarding
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Восстановить пароль"
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 24, weight: .regular, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "На указанный e-mail придет письмо с ссылкой для сброса пароля"
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.placeholder = "Введите e-mail"
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        textField.textColor = .appMediumGray
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var emailTFImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .email
        return imageView
    }()
    
    private lazy var emailTFView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appBeige
        return view
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.alpha = 0.5
        button.setTitle("Сбросить", for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension RestorePasswordViewController {
    
    func setupViews() {
        navigationItem.title = "Вход"
        
        view.addSubviews(posterImage, backView)
        backView.addSubviews(logoImage, titleLabel, subtitleLabel, emailTextField, emailTFImage, emailTFView, signInButton)
    }
    
    func setupConstraints() {
        posterImage.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(321)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(216)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(38)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(45)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(56)
        }
        
        emailTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        emailTFView.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(3)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.size.equalTo(CGSize(width: 296, height: 56))
            make.trailing.leading.equalToSuperview().inset(40)
        }
    }
}
