//
//  SupportViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SupportViewController: UIViewController {
    
    //MARK: UI Elements
    private lazy var supportTextField: UITextView = {
        let textField = UITextView()
        textField.isEditable = true
        textField.text = "Расскажите, что не работает?"
        textField.textColor = .appMainBrown
        textField.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.sizeToFit()
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Отправить", for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(sendToSupportTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        keyboardButton()
    }
}

//MARK: - Views & Constraints
private extension SupportViewController {
    
    func keyboardButton() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:
                                            UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:
                                            UIResponder.keyboardWillHideNotification, object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupViews() {
        navigationItem.title = "Служба поддержки"
    
        view.backgroundColor = .appWhite
        view.addSubviews(supportTextField, sendButton)
    }
    
    func setupConstraints() {
        
        supportTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.left.equalToSuperview().inset(20)
            make.bottom.equalTo(sendButton.snp.top).offset(40)
        }
        
        sendButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(35)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
}

//MARK: - Functions
private extension SupportViewController {
    
    @objc func sendToSupportTapped() {
        let description = supportTextField.text!
        
        SVProgressHUD.show()
        
        let parameters = ["problem_description": description]
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                multiPart.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: Urls.SUPPORT_URL).responseDecodable(of: SupportSend.self) { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                self.popViewControllerTap()
            } else {
                if let statusCode = response.response?.statusCode {
                    SVProgressHUD.showError(withStatus: "Server error: \(statusCode)")
                } else {
                    SVProgressHUD.showError(withStatus: "Unknown error")
                }
            }
        }
    }
    
    private func popViewControllerTap() {
        supportTextField.text = "Расскажите, что не работает?"
        navigationController?.popViewController(animated: true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Поднимаем кнопку выше клавиатуры
            let buttonBottomY = sendButton.frame.origin.y + sendButton.frame.size.height
            let spaceAboveKeyboard = view.frame.height - keyboardSize.height - buttonBottomY
            if spaceAboveKeyboard < 0 {
                animateButtonMoveY(y: spaceAboveKeyboard)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        animateButtonMoveY(y: 0)
    }
    
    private func animateButtonMoveY(y: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.sendButton.transform = CGAffineTransform(translationX: 0, y: y)
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
