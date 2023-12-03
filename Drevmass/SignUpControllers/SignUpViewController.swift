//
//  ViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 20.11.2023.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class SignUpViewController: UIViewController {
    
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
    
    private lazy var nameTextField: UITextField = createTextField(placeholder: "Введите имя", secureText: false)
    private lazy var nameTFImage: UIImageView = createImageView(image: UIImage(named: "person"))
    private lazy var nameTFView: UIView = createBeigeView()
    
    private lazy var emailTextField: UITextField = createTextField(placeholder: "Введите e-mail", secureText: false)
    private lazy var emailTFImage: UIImageView = createImageView(image: UIImage(named: "email"))
    private lazy var emailTFView: UIView = createBeigeView()
    
    private lazy var passwordTextField: UITextField = createTextField(placeholder: "Введите пароль", secureText: false)
    private lazy var passwordTFImage: UIImageView = createImageView(image: UIImage(named: "password"))
    private lazy var passwordTFView: UIView = createBeigeView()
    
    private lazy var repeatPasswordTextField: UITextField = createTextField(placeholder: "Повторите пароль", secureText: false)
    private lazy var repeatPasswordTFImage: UIImageView = createImageView(image: UIImage(named:"password"))
    private lazy var repeatPasswordTFView: UIView = createBeigeView()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.alpha = 0.5
        button.setTitle("Продолжить", for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
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
        hideKeyboardWhenTappedAround()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
}

//MARK: - Views & Constraints

private extension SignUpViewController {
    
    func setupViews() {
        navigationItem.title = "Регистрация"
        
        view.backgroundColor = .appWhite
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
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

//MARK: - Functions

private extension SignUpViewController {
    
    @objc func signUpButtonTapped() {
        let signUpName = nameTextField.text!
        let signUpEmail = emailTextField.text!
        let signUpPassword = passwordTextField.text!
        let confirmPassword = repeatPasswordTextField.text!
        
        if signUpPassword == confirmPassword {
            
            SVProgressHUD.show()
            
            let registrationUrl = Urls.REGISTER_URL
            let parameters = ["name": signUpName, "email": signUpEmail, "password": signUpPassword, "password_confirmation": confirmPassword]
            AF.upload(multipartFormData: { multiPart in
                for (key, value) in parameters {
                    multiPart.append(value.data(using: .utf8)!, withName: key)
                }
            }, to: registrationUrl).responseDecodable(of: SignUpInModel.self) { response in
                
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
                        // Успешная регистрация
                        Storage.sharedInstance.access_token = token
                        UserDefaults.standard.set(token, forKey: "access_token")
                        self.startUserForm()
                    } else {
                        SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                    }
                } else {
                    // Обработка ошибок сервера
                    if let statusCode = response.response?.statusCode {
                        SVProgressHUD.showError(withStatus: "Server error: \(statusCode)")
                    } else {
                        SVProgressHUD.showError(withStatus: "Unknown error")
                    }
                }
            }
        }
    }
    
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
    
    func startUserForm() {
        let formVC = UserInfoViewController()
        navigationController?.show(formVC, sender: self)
        navigationItem.title = ""
    }
}

//MARK: - TextField extensions

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nameText = nameTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        let confirmPassword = repeatPasswordTextField.text ?? ""
        
        if emailText.isEmpty || nameText.isEmpty || passwordText.isEmpty || confirmPassword.isEmpty {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
        } else {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1
        }
        
        return true
    }
}
