//
//  SecondProfileViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SecondProfileViewController: UIViewController {
    
    var selectedGender: Int = 0
    var selectedActivity: Int = 0
    var userID: Int?
    var info = Information()
    
    //MARK: - UI Elements
    private lazy var scrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.contentMode = .scaleToFill
        sv.contentInsetAdjustmentBehavior = .never
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
//        sv.frame = view.bounds
//        sv.contentSize = CGSize(width: view.frame.width, height: 950)
        sv.backgroundColor = .white
        return sv
    }()
    
    private lazy var contentScrollView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
//    private var contentSize: CGSize {
//        CGSize(width: view.frame.width, height: view.frame.height + 200)
//    }
    
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои данные"
        label.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваше имя"
        label.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        label.textColor = .appMediumGray
        return label
    }()
    
    private lazy var nameTextField: UITextField = createTextField(placeholder: "Введите имя", secureText: false)
    private lazy var nameTFImage: UIImageView = createImageView(image: UIImage(named: "person"))
    private lazy var nameTFView: UIView = createBeigeView()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш email"
        label.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        label.textColor = .appMediumGray
        return label
    }()
    
    private lazy var emailTextField: UITextField = createTextField(placeholder: "Введите email", secureText: false)
    private lazy var emailTFImage: UIImageView = createImageView(image: UIImage(named: "email"))
    private lazy var emailTFView: UIView = createBeigeView()
    
    private lazy var passwordTextField: UITextField = createTextField(placeholder: "Новый пароль", secureText: true)
    private lazy var passwordTFImage: UIImageView = createImageView(image: UIImage(named: "password"))
    private lazy var passwordTFView: UIView = createBeigeView()
    
    private lazy var repeatPasswordTextField: UITextField = createTextField(placeholder: "Повторите пароль", secureText: true)
    private lazy var repeatPasswordTFImage: UIImageView = createImageView(image: UIImage(named: "password"))
    private lazy var repeatPasswordTFView: UIView = createBeigeView()
    
    private lazy var formInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Анкетирование"
        label.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Пол"
        label.tintColor = .appBrown
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        return label
    }()
    
    private lazy var maleButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appLightGray
        button.setTitle("Мужской", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appBeige
        button.setTitle("Женский", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var heightTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.borderStyle = .none
        textField.textColor = .appBrown
        textField.placeholder = "Рост"
        textField.textAlignment = .right
        textField.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        return textField
    }()
    
    private lazy var heightLabel: UILabel = createLightLabel(title: "Рост")
    private lazy var smLabel: UILabel = createLightLabel(title: "см")
    private lazy var heightTFView: UIView = createBeigeView()
    
    private lazy var weightTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.borderStyle = .none
        textField.textColor = .appBrown
        textField.placeholder = "Вес"
        textField.textAlignment = .right
        textField.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        return textField
    }()
    
    private lazy var weightLabel: UILabel = createLightLabel(title: "Вес")
    private lazy var kgLabel: UILabel = createLightLabel(title: "кг")
    private lazy var weightTFView: UIView = createBeigeView()
    
    private lazy var dateLabel: UILabel = createLightLabel(title: "Дата рождения")
    private lazy var dateTFView: UIView = createBeigeView()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .none
        textField.textColor = .appBrown
        textField.inputView = datePicker
        textField.inputAccessoryView = toolbar
        textField.textAlignment = .right
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePick = UIDatePicker()
        datePick.datePickerMode = .date
        datePick.preferredDatePickerStyle = .wheels
        datePick.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePick
    }()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        return toolbar
    }()
    
    private lazy var activityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Ваша активность"
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }()
    
    private lazy var lowButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appLightGray
        button.setTitle("Низкая", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(activityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var middleButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appBeige
        button.setTitle("Средняя", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(activityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var highButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appLightGray
        button.setTitle("Высокая", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(activityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteAccount: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить аккаунт", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
        button.addTarget(self, action: #selector(deleteAlertShow), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        getUserInfo()
        hideKeyboardWhenTappedAround()
    }
}

//MARK: - Views & Constraints

private extension SecondProfileViewController {
    
    func setupViews() {
        navigationItem.title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTapped))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        
        view.backgroundColor = .appWhite
        view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        contentScrollView.addSubviews(userInfoLabel, nameLabel, nameTextField, nameTFImage, nameTFView, emailLabel, emailTextField, emailTFImage, emailTFView, passwordTextField, passwordTFImage, passwordTFView, repeatPasswordTextField, repeatPasswordTFImage, repeatPasswordTFView, formInfoLabel, genderLabel, maleButton, femaleButton, heightTextField, heightLabel, smLabel, heightTFView, weightTextField, weightLabel, kgLabel, weightTFView, dateLabel, dateTextField, dateTFView, activityLabel, highButton, middleButton, lowButton, deleteAccount)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.width.equalTo(scrollView.snp.width)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(102)
            make.left.equalToSuperview().inset(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(40)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(45)
        }
        
        nameTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(nameTextField)
            make.leading.equalTo(nameTextField.snp.leading)
        }
        
        nameTFView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTFView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(45)
        }
        
        emailTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        emailTFView.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTFView.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        passwordTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.leading.equalTo(passwordTextField.snp.leading)
        }
        
        passwordTFView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTFView.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        repeatPasswordTFImage.snp.makeConstraints { make in
            make.centerY.equalTo(repeatPasswordTextField)
            make.leading.equalTo(repeatPasswordTextField.snp.leading)
        }
        
        repeatPasswordTFView.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        formInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTFView.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.top.equalTo(formInfoLabel.snp.bottom).offset(14)
        }
        
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 144, height: 32))
        }
        
        femaleButton.snp.makeConstraints { make in
            make.centerY.equalTo(maleButton)
            make.trailing.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 144, height: 32))
        }
        
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(femaleButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalTo(smLabel.snp.leading)
            make.size.equalTo(CGSize(width: 290, height: 36))
        }
        
        heightLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heightTextField)
            make.leading.equalTo(heightTextField.snp.leading)
        }
        
        smLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalTo(heightTextField)
        }
        
        heightTFView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
            make.top.equalTo(heightTextField.snp.bottom)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTFView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(40)
            make.trailing.equalTo(kgLabel.snp.leading)
            make.size.equalTo(CGSize(width: 292, height: 36))
        }
        
        weightLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weightTextField)
            make.leading.equalTo(weightTextField.snp.leading)
        }
        
        kgLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalTo(weightTextField)
        }
        
        weightTFView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
            make.top.equalTo(weightTextField.snp.bottom)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(weightTFView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 292, height: 36))
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateTextField)
            make.leading.equalTo(dateTextField.snp.leading)
        }
        
        dateTFView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
            make.top.equalTo(dateTextField.snp.bottom)
        }
        
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(29)
            make.leading.equalToSuperview().inset(40)
        }
        
        highButton.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 88, height: 32))
        }
        
        middleButton.snp.makeConstraints { make in
            make.centerY.equalTo(highButton)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 88, height: 32))
        }
        
        lowButton.snp.makeConstraints { make in
            make.centerY.equalTo(middleButton)
            make.trailing.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 88, height: 32))
        }
        
        deleteAccount.snp.makeConstraints { make in
            make.top.equalTo(highButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(45)
        }
    }
}
    
//MARK: - Functions

private extension SecondProfileViewController {
    
    func getUserInfo() {
        
        SVProgressHUD.show()
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.access_token)"]
        AF.request(Urls.USER_INFORMATION_URL, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                let name = json ["name"]
                let email = json ["email"]
                self.nameTextField.text = name.stringValue
                self.emailTextField.text = email.stringValue
                self.info = Information(json: json)
                self.configureButtons()
            } else {
                SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                
                var ErrorString = "CONNECTION_ERROR"
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    private func configureButtons() {
        maleButton.backgroundColor = info.gender == 0 ? .appBeige : .appLightGray
        maleButton.titleLabel?.textColor = info.gender == 0 ? .appWhite : .appBrown
        femaleButton.backgroundColor = info.gender == 1 ? .appBeige : .appLightGray
        femaleButton.titleLabel?.textColor = info.gender == 1 ? .appWhite : .appBrown
        lowButton.backgroundColor = info.activity == 1 ? .appBeige : .appLightGray
        lowButton.titleLabel?.textColor = info.activity == 1 ? .appWhite : .appBrown
        middleButton.backgroundColor = info.activity == 2 ? .appBeige : .appLightGray
        middleButton.titleLabel?.textColor = info.activity == 2 ? .appWhite : .appBrown
        highButton.backgroundColor = info.activity == 3 ? .appBeige : .appLightGray
        highButton.titleLabel?.textColor = info.activity == 3 ? .appWhite : .appBrown
        weightTextField.text = info.weight
        heightTextField.text = info.height
        dateTextField.text = info.birth
    }
    
    @objc private func saveTapped() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = repeatPasswordTextField.text ?? ""
        let height = heightTextField.text ?? ""
        let weight = weightTextField.text ?? ""
        let birth = dateTextField.text ?? ""
        let gender = maleButton.backgroundColor == .appBeige ? true : false
        let activity =  lowButton.backgroundColor == .appBeige ? 1 :
        (middleButton.backgroundColor == .appBeige ? 2 : 3)
        
        if password != confirmPassword {
            SVProgressHUD.showError(withStatus: "Пароли должны совпадать")
            return
        }
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.access_token)"]
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": confirmPassword,
            "information": [
                "gender": gender,
                "height": height,
                "weight": weight,
                "birth": birth,
                "activity": activity
            ]
        ]
        
        AF.request(Urls.USER_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                print("User information updated successfully")
                
                self.navigationController?.popViewController(animated: true)
            } else {
                SVProgressHUD.showError(withStatus: resultString)
                
                let errorString = "CONNECTION_ERROR" + " \(response.response?.statusCode ?? -1) \(resultString)"
                SVProgressHUD.showError(withStatus: errorString)
            }
        }
    }
    
    @objc private func genderButtonTapped(sender: UIButton) {
        let genderButtons = [maleButton, femaleButton]
        
        for button in genderButtons {
            button.isSelected = false
            button.backgroundColor = .appLightGray
            button.setTitleColor(.appBrown, for: .normal)
        }
        sender.isSelected = true
        sender.backgroundColor = .appBeige
        sender.setTitleColor(.appWhite, for: .normal)
        
        if sender == maleButton {
            selectedGender = 0
        } else if sender == femaleButton {
            selectedGender = 1
        }
    }
    
    @objc private func activityButtonTapped(sender: UIButton) {
        let activityButton = [lowButton, middleButton, highButton]
        
        for button in activityButton {
            button.isSelected = false
            button.backgroundColor = .appLightGray
            button.setTitleColor(.appBrown, for: .normal)
        }
        sender.isSelected = true
        sender.backgroundColor = .appBeige
        sender.setTitleColor(.appWhite, for: .normal)
        
        if sender == lowButton {
            selectedActivity = 1
        } else if sender == middleButton {
            selectedActivity = 2
        } else if sender == highButton {
            selectedActivity = 3
        }
    }
    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func doneButtonTapped() {
        dateTextField.resignFirstResponder()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func deleteAlertShow() {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите удалить аккаунт?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            self?.confirmDelete()
        }
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "Вы точно хотите удалить аккаунт?", message: "Это действие необратимо!", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Да, удалить", style: .destructive) { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: "access_token")
            self?.deleteAccountTapped()
        }
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
    func deleteAccountTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        SVProgressHUD.show()
        
        let parameters = ["email": email, "password": password]
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                multiPart.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: Urls.DELETE_USER_URL).responseDecodable(of: DeleteUser.self) { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                if let message = json["message"].string {
                    self.logoutDelete()
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
    
    func logoutDelete() {
        DispatchQueue.main.async {
            let rootVC = UINavigationController(rootViewController: OnboardingVC())
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            UserDefaults.standard.removeObject(forKey: "access_token")
            appDelegate.window?.rootViewController = rootVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}
