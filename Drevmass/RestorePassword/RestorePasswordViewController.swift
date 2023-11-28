//
//  RestorePasswordViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 23.11.2023.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

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
    
    private lazy var emailTextField: UITextField = createTextField(placeholder: "Введите e-mail", secureText: false)
    private lazy var emailTFImage: UIImageView = createImageView(image: UIImage(named: "email"))
    private lazy var emailTFView: UIView = createBeigeView()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Сбросить", for: .normal)
        button.alpha = 0.5
        button.configuration?.titleAlignment = .center
        button.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
        button.layer.cornerRadius = 30
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        emailTextField.delegate = self
    }
}

private extension RestorePasswordViewController {
    
    func setupViews() {
        navigationItem.title = "Вход"
        navigationController?.setDefaultNavigationBarAppearance()
        
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

extension RestorePasswordViewController {
    
    @objc func resetPasswordTapped() {
        let email = emailTextField.text!
        
        SVProgressHUD.show()
        
        let loginUrl = Urls.FORGET_URL
        let parameters = ["email": email]
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                multiPart.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: loginUrl).responseDecodable(of: Reset.self) { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                if let status = json["status"].string {
                    self.showAlert(title: "Подтверждение", message: "Письмо с ссылкой на восстановление отправлено!")
                } else {
                    self.showAlert(title: "Неверный e-mail!", message: "Мы не нашли данный email в базе пользователей")
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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension RestorePasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let emailText = emailTextField.text ?? ""
        
        if emailText.isEmpty {
            signInButton.isEnabled = false
            signInButton.alpha = 0.5
        } else {
            signInButton.isEnabled = true
            signInButton.alpha = 1
        }
        
        return true
    }
}
