//
//  ProductCollectionViewCell.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit
import SnapKit

class LessonsCollectionViewCell: UICollectionViewCell {
 
  public let identifier = "LessonsCell"
    
    //MARK: - UI Elements
    
    private lazy var lessonLabel: UILabel = {
        let label = UILabel()
        label.text = "Урок 1"
        label.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteLessons"), for: .normal)
        
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Деревянный роликовый тренажер-массажер для спины Древмасс. Полная комплектация и сборка массажера"
        label.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        label.textColor = .appGray
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var lessonImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "preview")
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playLessons"), for: .normal)
        
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5:13"
        label.font = .appFont(ofSize: 14, weight: .light, font: .Rubik)
        label.textColor = .appBeige
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 11.5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LessonsCollectionViewCell {
    
    func commonInit() {
           layer.cornerRadius = 40
           layer.borderWidth = 1
           layer.borderColor = UIColor(red: 0.88, green: 0.87, blue: 0.87, alpha: 1).cgColor
       }
    
    func setupViews() {
        contentView.backgroundColor = .appWhite
        contentView.addSubviews(lessonLabel, favoriteButton, descriptionLabel, lessonImageView, playButton, timeLabel)
    }
    
    func setupConstraints() {
        lessonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalTo(favoriteButton)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.leading.equalTo(lessonLabel.snp.trailing).offset(10)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lessonLabel.snp.bottom).offset(9)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        lessonImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(21)
            make.trailing.leading.bottom.equalToSuperview().inset(8)
        }
        
        playButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(24)
            make.size.equalTo(CGSize(width: 56, height: 56))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(24)
            make.width.equalTo(46)
        }
    }
}
