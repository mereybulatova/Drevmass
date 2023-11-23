//
//  ViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 20.11.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .logoOnboarding
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Присоединяйтесь к нам!"
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 24, weight: .regular, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Заполните поля, чтобы создать аккаунт."
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.placeholder = "Ваше имя"
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        textField.textColor = .appMediumGray
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var nameTFImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .person
        return imageView
    }()
    
    private lazy var nameTFView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appBeige
        return view
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
        textField.borderStyle = .none
        textField.isSecureTextEntry = true
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
    
    private lazy var repeatPasswordTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.placeholder = "Повторите пароль"
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        textField.textColor = .appMediumGray
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var repeatPasswordTFImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .password
        return imageView
    }()
    
    private lazy var repeatPasswordTFView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appBeige
        return view
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.alpha = 0.5
        button.setTitle("Продолжить", for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        return button
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Есть аккаунт?"
        label.tintColor = .appBrown
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        button.setTitleColor(.appBeige, for: .normal)
        
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Views & Constraints

private extension SignUpViewController {
    
    func setupViews() {
        navigationItem.title = "Регистрация"
        view.backgroundColor = .appWhite
        view.addSubviews(
            logoImage, titleLabel, subtitleLabel, nameTextField, nameTFImage, nameTFView, emailTextField, emailTFImage, emailTFView, passwordTextField, passwordTFImage, passwordTFView, repeatPasswordTextField, repeatPasswordTFImage, repeatPasswordTFView, signUpButton, signInLabel, signInButton
        )
    }
    
    func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(60)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(56)
        }
        
        nameTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(nameTextField)
            make.leading.equalTo(nameTextField.snp.leading)
        }
        
        nameTFView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).inset(3)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
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
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(56)
        }
        
        repeatPasswordTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(repeatPasswordTextField)
            make.leading.equalTo(repeatPasswordTextField.snp.leading)
        }
        
        repeatPasswordTFView.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).inset(3)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(32)
            make.trailing.leading.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 296, height: 56))
        }
        
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(101)
            make.leading.equalToSuperview().inset(117)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerY.equalTo(signInLabel)
            make.leading.equalTo(signInLabel.snp.trailing).offset(5)
        }
    }
}

private extension SignUpViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func signInButtonTapped() {
        let signUpVC = SignInViewController()
        navigationController?.show(signUpVC, sender: true)
        navigationItem.title = ""
    }
}
