//
//  SignInViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 22.11.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
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
        
        label.text = "Добро пожаловать в Drevmass"
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 24, weight: .regular, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Заполните поля, чтобы войти в аккаунт."
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
    
    private lazy var passwordTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.placeholder = "Введите пароль"
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        textField.textColor = .appMediumGray
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var passwordTFImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .password
        return imageView
    }()
    
    private lazy var passwordTFView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appBeige
        return view
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.alpha = 0.5
        button.setTitle("Войти", for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.appBeige, for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.borderColor = UIColor(red: 0.71, green: 0.639, blue: 0.502, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgetPasswordLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Забыли пароль?"
        label.tintColor = .appBrown
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Восстановить", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        button.setTitleColor(.appBeige, for: .normal)
        
        button.addTarget(self, action: #selector(restorePasswordTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Add Views & Constraints

private extension SignInViewController {
    
    func setupViews() {
        navigationItem.title = "Вход"
        
        view.addSubviews(posterImage, backView)
        backView.addSubviews(logoImage, titleLabel, subtitleLabel, emailTextField, emailTFImage, emailTFView, passwordTextField, passwordTFImage, passwordTFView, signInButton, signUpButton, forgetPasswordLabel, forgetPasswordButton)
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
            make.width.equalTo(280)
            make.centerX.equalToSuperview()
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
        
         passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(56)
        }
        
        passwordTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.leading.equalTo(passwordTextField.snp.leading)
        }
        
        passwordTFView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(3)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.size.equalTo(CGSize(width: 296, height: 56))
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(8)
            make.size.equalTo(CGSize(width: 296, height: 56))
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        forgetPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(45)
            make.leading.equalToSuperview().inset(80)
        }
        
        forgetPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(forgetPasswordLabel)
            make.leading.equalTo(forgetPasswordLabel.snp.trailing).offset(5)
        }
    }
}

//MARK: - Add func

private extension SignInViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.show(signUpVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc func restorePasswordTapped() {
        let restoreVC = RestorePasswordViewController()
        navigationController?.show(restoreVC, sender: self)
        navigationItem.title = ""
    }
}
