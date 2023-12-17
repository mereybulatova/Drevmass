//
//  ProfileNotificationsViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ProfileNotificationsViewController: UIViewController {
    //MARK: - Properties
    
    var userID: Int?
    var selectedDays: Int = 0
    var day = Day()
    
    //MARK: - UI Elements
    
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
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(saveNotificationSettings), for: .primaryActionTriggered)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        getNotificationInfo()
    }
}

    //MARK: - Views & constraints

private extension ProfileNotificationsViewController {
    func setupViews() {
        navigationItem.title = "Настройка уведомлений"
        
        view.backgroundColor = .appWhite
        view.addSubviews(
            chooseDayLabel, weekdayStackView, timeLabel, datePicker, nextButton
        )
    }
    
    func setupConstraints() {
        chooseDayLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
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
            make.top.equalTo(datePicker.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview().inset(40)
            make.size.equalTo(CGSize(width: 296, height: 61))
        }
    }
}

//MARK: - Function

extension ProfileNotificationsViewController {
    
    func getNotificationInfo() {
        
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
                self.day = Day(json: json)
                self.configureDay()
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
    
    @objc
    func saveNotificationSettings() {
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
            
            if response.response?.statusCode == 200 {                self.navigationController?.popViewController(animated: true)
                
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
    
    func configureDay() {
        weekdayButtons[0].backgroundColor = day.monday != 0 ? .appBeige : .appWhite
        weekdayButtons[1].backgroundColor = day.tuesday != 0 ? .appBeige : .appWhite
        weekdayButtons[2].backgroundColor = day.wednesday != 0 ? .appBeige : .appWhite
        weekdayButtons[3].backgroundColor = day.thursday != 0 ? .appBeige : .appWhite
        weekdayButtons[4].backgroundColor = day.friday != 0 ? .appBeige : .appWhite
        weekdayButtons[5].backgroundColor = day.saturday != 0 ? .appBeige : .appWhite
        weekdayButtons[6].backgroundColor = day.sunday != 0 ? .appBeige : .appWhite

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH:mm:ss"

        if let time = dateFormatter.date(from: day.time) {
            datePicker.date = time
        }
    }
    
    public func createWeekdayButton(title: String) -> UIButton {
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
        if let index = weekdayButtons.firstIndex(of: sender) {
            sender.backgroundColor = (sender.backgroundColor == .appBeige) ? .appWhite : .appBeige
        }
    }
}
