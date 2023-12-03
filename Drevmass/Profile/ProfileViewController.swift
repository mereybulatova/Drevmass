//
//  ProfileViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import StoreKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var userID: Int?
    
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
        
        imageView.image = UIImage(named: "profilePoster")
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
        
        label.text = "Привет, Мерей!"
        label.textColor = .appBrown
        label.textAlignment = .center
        label.font = .appFont(ofSize: 24, weight: .regular, font: .Rubik)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        
        label.text = "mereybulatova05@gmail.com"
        label.textColor = .appMediumGray
        label.textAlignment = .center
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        return label
    }()
    
    private lazy var profileButton: UIButton = createProfileButton(title: "Профиль")
    private lazy var profileImageView: UIImageView = createImageView(image: UIImage(named: "profile"))
    private lazy var lineProfile: UIView = createLightGrayView()
    
    private lazy var notificationsButton: UIButton = createProfileButton(title: "Уведомления")
    private lazy var notificationsImageView: UIImageView = createImageView(image: UIImage(named: "notifications"))
    private lazy var lineNotifications: UIView = createLightGrayView()
   
    private lazy var informationButton: UIButton = createProfileButton(title: "Правовая информация")
    private lazy var informationImageView: UIImageView = createImageView(image: UIImage(named: "information"))
    private lazy var lineInformations: UIView = createLightGrayView()
   
    private lazy var supportButton: UIButton = createProfileButton(title: "Служба поддержки")
    private lazy var supportImageView: UIImageView = createImageView(image: UIImage(named: "support"))
    private lazy var lineSupport: UIView = createLightGrayView()
    
    private lazy var appButton: UIButton = createProfileButton(title: "О приложении")
    private lazy var appImageView: UIImageView = createImageView(image: UIImage(named: "app"))
    private lazy var lineApp: UIView = createLightGrayView()
    
    private lazy var feedbackButton: UIButton = createProfileButton(title: "Оставить отзыв")
    private lazy var feedbackImageView: UIImageView = createImageView(image: UIImage(named: "feedback"))
    private lazy var lineFeedback: UIView = createLightGrayView()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addUserName()
        setupViews()
        setupConstraints()
        targetButtons()
    }
}

//MARK: - Views & Constraints

private extension ProfileViewController {
    
    func setupViews() {
        view.backgroundColor = .appWhite
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(posterImage, backView)
        backView.addSubviews(logoImage, titleLabel, emailLabel, profileButton, profileImageView, lineProfile, notificationsButton, notificationsImageView, lineNotifications, informationButton, informationImageView, lineInformations, supportButton, supportImageView, lineSupport, appButton, appImageView, lineApp, feedbackButton, feedbackImageView, lineFeedback)
        
        navigationItem.title = "Профиль"
        navigationController?.setDefaultNavigationBarAppearance()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(logOutButton))
    }
    
    func setupConstraints() {
        posterImage.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
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
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.height.equalTo(56)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalTo(profileButton)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        lineProfile.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        notificationsButton.snp.makeConstraints { make in
            make.top.equalTo(lineProfile.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(notificationsImageView.snp.trailing).offset(15)
            make.height.equalTo(56)
        }
        
        notificationsImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalTo(notificationsButton)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        lineNotifications.snp.makeConstraints { make in
            make.top.equalTo(notificationsButton.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        informationButton.snp.makeConstraints { make in
            make.top.equalTo(lineNotifications.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(informationImageView.snp.trailing).offset(15)
            make.height.equalTo(56)
        }
        
        informationImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalTo(informationButton)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        lineInformations.snp.makeConstraints { make in
            make.top.equalTo(informationButton.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        supportButton.snp.makeConstraints { make in
            make.top.equalTo(lineInformations.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(supportImageView.snp.trailing).offset(15)
            make.height.equalTo(56)
        }
        
        supportImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalTo(supportButton)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        lineSupport.snp.makeConstraints { make in
            make.top.equalTo(supportButton.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        appButton.snp.makeConstraints { make in
            make.top.equalTo(lineSupport.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(appImageView.snp.trailing).offset(15)
            make.height.equalTo(56)
        }
        
        appImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalTo(appButton)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        lineApp.snp.makeConstraints { make in
            make.top.equalTo(appButton.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        feedbackButton.snp.makeConstraints { make in
            make.top.equalTo(lineApp.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(feedbackImageView.snp.trailing).offset(15)
            make.height.equalTo(56)
        }
        
        feedbackImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalTo(feedbackButton)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        lineFeedback.snp.makeConstraints { make in
            make.top.equalTo(feedbackButton.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
}

//MARK: - Functions

private extension ProfileViewController {
    
    func targetButtons() {
        profileButton.addTarget(self, action: #selector(secondProfileTapped), for: .touchUpInside)
        notificationsButton.addTarget(self, action: #selector(notificationsTapped), for: .touchUpInside)
        informationButton.addTarget(self, action: #selector(informationTapped), for: .touchUpInside)
        supportButton.addTarget(self, action: #selector(supportTapped), for: .touchUpInside)
        appButton.addTarget(self, action: #selector(appTapped), for: .touchUpInside)
        feedbackButton.addTarget(self, action: #selector(feedbackTapped), for: .touchUpInside)
    }
    
    func addUserName() {
        SVProgressHUD.show()
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.access_token)"]
        
        AF.request(Urls.USER_URL, method: .get, headers: headers).validate().responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                let name = json["name"]
                let email = json["email"]
                self.userID = json["id"].int
                self.titleLabel.text = "Привет, \(name.stringValue)!"
                self.emailLabel.text = email.stringValue
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
    
    @objc private func logOutButton() {
        showLogoutAlert()
    }
    
    func showLogoutAlert() {
        let alert = UIAlertController(title: "Подтверждение", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let logoutAction = UIAlertAction(title: "Выйти", style: .destructive) { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: "access_token")
            self?.logout()
        }
        alert.addAction(logoutAction)
        present(alert, animated: true, completion: nil)
    }

    func logout() {
        DispatchQueue.main.async {
            let rootVC = UINavigationController(rootViewController: OnboardingVC())
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootVC
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    @objc private func secondProfileTapped() {
        let secondProfileVC = SecondProfileViewController()
        navigationController?.show(secondProfileVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc private func notificationsTapped() {
        let profileNotificationVC = ProfileNotificationsViewController()
        navigationController?.show(profileNotificationVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc private func informationTapped() {
        let infoVC = InformationViewController()
        navigationController?.show(infoVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc private func supportTapped() {
        let supportVC = SupportViewController()
        navigationController?.show(supportVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc private func appTapped() {
        let appVC = AppViewController()
        navigationController?.show(appVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc private func feedbackTapped() {
    }
}
