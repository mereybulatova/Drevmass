//
//  FormViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 23.11.2023.
//

import UIKit
import AdvancedPageControl

class FormViewController: UIViewController {
    
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
        return button
    }()
    
    private lazy var femaleButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appBeige
        button.setTitle("Женский", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
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
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Рост"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }()
    
    private lazy var smLabel: UILabel = {
        let label = UILabel()
        
        label.text = "см"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }()
    
    private lazy var heightTFView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appBeige
        return view
    }()
    
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
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Вес"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }()
    
    private lazy var kgLabel: UILabel = {
        let label = UILabel()
        
        label.text = "кг"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }()
    
    private lazy var weightTFView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appBeige
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Дата рождения"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.tintColor = .appBrown
        return label
    }()
    
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
        datePick.addTarget(self, action: #selector(chooseDate), for: .valueChanged)
        return datePick
    }()
    
    private lazy var dateTFView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .appBeige
        return view
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
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var middleButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appBeige
        button.setTitle("Средняя", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var highButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .appLightGray
        button.setTitle("Высокая", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Следующий вопрос", for: .normal)
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(.appGray, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        
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

private extension FormViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubviews(logoImage, titleLabel, subtitleLabel, genderLabel, maleButton, femaleButton, heightTextField, heightLabel, smLabel, heightTFView, weightTextField, weightLabel, kgLabel, weightTFView, dateTextField, datePicker, dateLabel, dateTFView, activityLabel, lowButton, middleButton, highButton, nextButton, skipButton, pageControl)
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
        
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateTextField)
            make.trailing.equalTo(dateTextField.snp.trailing)
        }
        
        dateTFView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview().inset(40)
            make.top.equalTo(dateTextField.snp.bottom)
        }
    }
}

private extension FormViewController {
    
    @objc private func chooseDate() {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd.MM.yyyy"
           dateTextField.text = dateFormatter.string(from: datePicker.date)
       }
}
