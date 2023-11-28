//
//  SecondProfileViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit

class SecondProfileViewController: UIViewController {
    
    //MARK: - UI Elements
    
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
        let textField = TextFieldWithPadding()
        
        textField.borderStyle = .none
        textField.textColor = .appBrown
        textField.inputView = datePicker
        textField.textAlignment = .right
        textField.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePick = UIDatePicker()
        datePick.datePickerMode = .date
        return datePick
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
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension SecondProfileViewController {
    
    func setupViews() {
        navigationItem.title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTapped))
        
        view.backgroundColor = .appWhite
        view.addSubviews(userInfoLabel, nameLabel, nameTextField, nameTFImage, nameTFView, emailLabel, emailTextField, emailTFImage, emailTFView, passwordTextField, passwordTFImage, passwordTFView, repeatPasswordTextField, repeatPasswordTFImage, repeatPasswordTFView, formInfoLabel, genderLabel, maleButton, femaleButton, heightTextField, heightLabel, smLabel, heightTFView, weightTextField, weightLabel, kgLabel, weightTFView, dateLabel, dateTextField, datePicker, dateTFView, activityLabel, highButton, middleButton, lowButton, deleteAccount)
    }
    
    func setupConstraints() {
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(18)
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
        
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateTextField)
            make.trailing.equalTo(dateTextField.snp.trailing)
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
        }
    }
}
    
private extension SecondProfileViewController {
    
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
    }
    
    @objc private func saveTapped() {
        
    }
}
