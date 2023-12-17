//
//  FormViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 23.11.2023.
//

import UIKit
import AdvancedPageControl
import SVProgressHUD
import SwiftyJSON
import Alamofire

class UserInfoViewController: UIViewController {
    
    var selectedGender: Int = 0
    var selectedActivity: Int = 0
    var userID: Int?
    
    
    //MARK: - UI Elements
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = .logoOnboarding
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "7 минут в день для здоровой спины!"
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 24, weight: .regular, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Расскажи нам о себе, чтобы мы могли улучшить ваши занятия и здоровье."
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        label.numberOfLines = 0
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
        textField.keyboardType = .numberPad
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
        textField.keyboardType = .numberPad
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

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Следующий вопрос", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        button.addTarget(self, action: #selector(infoFormPost), for: .touchUpInside)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(.appGray, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: AdvancedPageControlView = {
        let pageControl = AdvancedPageControlView()

        pageControl.drawer = ColorBlendDrawer(
            numberOfPages: 2,
            height: 8,
            width: 8,
            space: 12,
            raduis: 5,
            indicatorColor: .appBeige,
            dotsColor: .appLightGray
        )
        return pageControl
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Views & Constraints

private extension UserInfoViewController {
    
    func setupViews() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        
        view.backgroundColor = .white
        view.addSubviews(
        logoImage, titleLabel, subtitleLabel, genderLabel, maleButton, femaleButton, heightTextField, heightLabel, smLabel, heightTFView, weightTextField, weightLabel, kgLabel, weightTFView, dateTextField, dateLabel, dateTFView, activityLabel, lowButton, middleButton, highButton, nextButton, skipButton, pageControl
        )
    }
    
    func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
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
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(76)
            make.trailing.leading.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 296, height: 61))
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(skipButton)
            make.size.equalTo(CGSize(width: 38, height: 8))
        }
    }
}

//MARK: - Functions

private extension UserInfoViewController {
    
   
    
    @objc func infoFormPost() {
        let gender = maleButton.backgroundColor == .appBeige ? "0" : "1"
        let activity =  lowButton.backgroundColor == .appBeige ? "1" :
        (middleButton.backgroundColor == .appBeige ? "2" : "3")
        let height = heightTextField.text ?? ""
        let weight = weightTextField.text ?? ""
        let birth = dateTextField.text ?? ""
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.access_token)"]
        
        let parameters = ["gender": gender, "activity": activity, "height": height, "weight": weight, "birth": birth]
        
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                multiPart.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: Urls.INFORMATION_POST_URL, headers: headers).responseDecodable(of: UserInformation.self) { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
            } else {
                    if let statusCode = response.response?.statusCode {
                        SVProgressHUD.showError(withStatus: "Server error: \(statusCode)")
                    } else {
                        SVProgressHUD.showError(withStatus: "Unknown error")
                    }
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
    
    @objc private func nextButtonTapped() {
        let notificationVC = NotificationViewController()
        navigationController?.show(notificationVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc private func skipButtonTapped() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func doneButtonTapped() {
           dateTextField.resignFirstResponder()
       }
}
