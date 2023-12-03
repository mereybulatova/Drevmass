//
//  AppViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit

class AppViewController: UIViewController {
    
    //MARK: - UI Elements
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = .logoOnboarding
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Древмасс"
        label.font = .appFont(ofSize: 24, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        label.textAlignment = .center
        return label
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Версия 1.0.0"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.textColor = .appMediumGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "© 2023 Древмасс Все права защищены"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.textColor = .appMediumGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: Views & Constraints
extension AppViewController {
    
    func setupViews() {
        navigationItem.title = "О приложении"
        
        view.backgroundColor = .appWhite
        view.addSubviews(logoImageView, nameLabel, versionLabel, yearLabel)
    }
    
    func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(270)
            make.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.centerX.equalTo(logoImageView)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.centerX.equalTo(nameLabel)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.centerX.equalTo(versionLabel)
        }
    }
}
