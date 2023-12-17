//
//  NotificationViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 23.11.2023.
//

import UIKit
import AdvancedPageControl
import SVProgressHUD
import SwiftyJSON
import Alamofire

class NotificationViewController: UIViewController {
    
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
        
        label.text = "Мы можем вам напоминать, что пришло время уделить здоровью."
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var chooseDayLabel: UILabel = {
        let label = UILabel()
        
        label.text = "По каким дням хотите заниматься?"
        label.tintColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
        return label
    }()
    
    private lazy var weekdayButtons: [UIButton] = {
        let weekdays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
        return weekdays.map { createWeekdayButton(title: $0) }
    }()
    
    private lazy var weekdayStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: weekdayButtons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "В какое время?"
        label.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePick = UIDatePicker()
        datePick.datePickerMode = .time
        datePick.minuteInterval = 1
        datePick.locale = Locale(identifier: "en_GB")
        
        let defaultTime = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())
        datePick.date = defaultTime ?? Date()
        
        if let textField = datePick.subviews.first(where: { $0 is UITextField }) as? UITextField {
            textField.font = .appFont(ofSize: 22, weight: .regular, font: .Rubik)
    }
        return datePick
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Начать заниматься!", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        
        button.addTarget(self, action: #selector(startAppTapped), for: .primaryActionTriggered)
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
            indicatorColor: .appLightGray,
            dotsColor: .appBeige
        )
        return pageControl
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Views & constraints

private extension NotificationViewController {
    
    func setupViews() {
        view.backgroundColor = .appWhite
        view.addSubviews(
            logoImage, titleLabel, subtitleLabel, chooseDayLabel, weekdayStackView, timeLabel, datePicker, nextButton, skipButton, pageControl
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
        
        chooseDayLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(24)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(130)
        }
        
        weekdayStackView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(24)
            make.top.equalTo(chooseDayLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(weekdayStackView.snp.bottom).offset(38)
            make.centerX.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
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

//MARK: - Function

extension NotificationViewController {
    
    @objc
    func startAppTapped() {
        SVProgressHUD.show()
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.access_token)"]

        let monday = weekdayButtons[0].backgroundColor == .appBeige ? "1" : "0"
        let tuesday = weekdayButtons[1].backgroundColor == .appBeige ? "1" : "0"
        let wednesday = weekdayButtons[2].backgroundColor == .appBeige ? "1" : "0"
        let thursday = weekdayButtons[3].backgroundColor == .appBeige ? "1" : "0"
        let friday = weekdayButtons[4].backgroundColor == .appBeige ? "1" : "0"
        let saturday = weekdayButtons[5].backgroundColor == .appBeige ? "1" : "0"
        let sunday = weekdayButtons[6].backgroundColor == .appBeige ? "1" : "0"

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH:mm"

        let time = dateFormatter.string(from: datePicker.date)

        AF.upload(multipartFormData: { form in
            form.append(monday.data(using: .utf8)!, withName: "monday")
            form.append(tuesday.data(using: .utf8)!, withName: "tuesday")
            form.append(wednesday.data(using: .utf8)!, withName: "wednesday")
            form.append(thursday.data(using: .utf8)!, withName: "thursday")
            form.append(friday.data(using: .utf8)!, withName: "friday")
            form.append(saturday.data(using: .utf8)!, withName: "saturday")
            form.append(sunday.data(using: .utf8)!, withName: "sunday")
            form.append(time.data(using: .utf8)!, withName: "time")
        }, to: Urls.NOTIFICATION_URL, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 ||
                response.response?.statusCode == 201 {
                self.skipButtonTapped()
                
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
    
     func createWeekdayButton(title: String) -> UIButton {
         let button = UIButton()
         
         button.setTitle(title, for: .normal)
         button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
         button.setTitleColor(.black, for: .normal)
         button.layer.cornerRadius = 20
         button.layer.borderWidth = 1
         button.layer.borderColor = UIColor(red: 0.71, green: 0.64, blue: 0.5, alpha: 1).cgColor
         button.addTarget(self, action: #selector(weekdayButtonTapped(_:)), for: .touchUpInside)
         return button
     }
    
    @objc public func weekdayButtonTapped(_ sender: UIButton) {
        if (weekdayButtons.firstIndex(of: sender) != nil) {
            sender.backgroundColor = (sender.backgroundColor == .appBeige) ? .appWhite : .appBeige
        }
    }
    
    @objc func skipButtonTapped() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }
}
