//
//  SignInViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 22.11.2023.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class SignInViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var scrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.contentInsetAdjustmentBehavior = .never
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.frame = view.bounds
        sv.contentSize = contentSize
        sv.backgroundColor = .white
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        return view
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 100)
    }
    
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
    
    private lazy var emailTextField: UITextField = createTextField(placeholder: "Введите e-mail", secureText: false)
    private lazy var emailTFImage: UIImageView = createImageView(image: UIImage(named: "email"))
    private lazy var emailTFView: UIView = createBeigeView()
    
    private lazy var passwordTextField: UITextField = createTextField(placeholder: "Введите пароль", secureText: true)
    private lazy var passwordTFImage: UIImageView = createImageView(image: UIImage(named: "password"))
    private lazy var passwordTFView: UIView = createBeigeView()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.alpha = 0.5
        button.setTitle("Войти", for: .normal)
        button.configuration?.titleAlignment = .center
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
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
        hideKeyboardWhenTappedAround()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

//MARK: - Views & Constraints

 extension SignInViewController {
    
    func setupViews() {
        navigationItem.title = "Вход"
        
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(posterImage, backView)
        backView.addSubviews(
            logoImage, titleLabel, subtitleLabel, emailTextField, emailTFImage, emailTFView, passwordTextField, passwordTFImage, passwordTFView, signInButton, signUpButton, forgetPasswordLabel, forgetPasswordButton
        )
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

//MARK: - Functions

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
    
    @objc func signInButtonTapped() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        SVProgressHUD.show()
        
        let loginUrl = Urls.LOGIN_URL
        let parameters = ["email": email, "password": password]
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                multiPart.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: loginUrl).responseDecodable(of: SignUpInModel.self) { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                if let token = json["access_token"].string {
                    Storage.sharedInstance.access_token = token
                    UserDefaults.standard.set(token, forKey: "access_token")
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                }
            } else {
                if let statusCode = response.response?.statusCode {
                    SVProgressHUD.showError(withStatus: "Server error: \(statusCode)")
                } else {
                    SVProgressHUD.showError(withStatus: "Unknown error")
                }
            }
        }
    }
    
    func startApp() {
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true)
    }
}

//MARK: - TextField extensions

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        if emailText.isEmpty || passwordText.isEmpty {
            signInButton.isEnabled = false
            signInButton.alpha = 0.5
        } else {
            signInButton.isEnabled = true
            signInButton.alpha = 1
        }
        return true
    }
}
