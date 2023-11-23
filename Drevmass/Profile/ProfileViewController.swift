//
//  ProfileViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - UI Elements
    
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
    
    private lazy var profileButton: UIButton = createButton(title: "Профиль")
    private lazy var profileImageView: UIImageView = createImageView(image: UIImage(named: "profile"))
    private lazy var lineProfile: UIView = createLineView()
    
    private lazy var notificationsButton: UIButton = createButton(title: "Уведомления")
    private lazy var notificationsImageView: UIImageView = createImageView(image: UIImage(named: "notifications"))
    private lazy var lineNotifications: UIView = createLineView()
   
    private lazy var informationButton: UIButton = createButton(title: "Правовая информация")
    private lazy var informationImageView: UIImageView = createImageView(image: UIImage(named: "information"))
    private lazy var lineInformations: UIView = createLineView()
   
    private lazy var supportButton: UIButton = createButton(title: "Служба поддержки")
    private lazy var supportImageView: UIImageView = createImageView(image: UIImage(named: "support"))
    private lazy var lineSupport: UIView = createLineView()
    
    private lazy var appButton: UIButton = createButton(title: "О приложении")
    private lazy var appImageView: UIImageView = createImageView(image: UIImage(named: "app"))
    private lazy var lineApp: UIView = createLineView()
    
    private lazy var feedbackButton: UIButton = createButton(title: "Оставить отзыв")
    private lazy var feedbackImageView: UIImageView = createImageView(image: UIImage(named: "feedback"))
    private lazy var lineFeedback: UIView = createLineView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension ProfileViewController {
    
    func setupViews() {
        view.backgroundColor = .appWhite
        view.addSubviews(posterImage, backView)
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


private extension ProfileViewController {
    
    @objc private func logOutButton() {
        
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.appBrown, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        return button
    }
    
    private func createImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }

    private func createLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = .appLightGray
        return view
    }
}
