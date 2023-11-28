//
//  ProductCollectionViewCell.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit
import SnapKit
import SDWebImage
import Alamofire
import SVProgressHUD

protocol LessonProtocol {
    func lessonDidSelect(lesson: Lessons)
}

class LessonsCollectionViewCell: UICollectionViewCell {
    
    var lesson = Lessons()
    
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
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
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
        label.layer.cornerRadius = 9
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

extension LessonsCollectionViewCell {
    
    func commonInit() {
           layer.cornerRadius = 15
           layer.borderWidth = 1
           layer.borderColor = UIColor(red: 0.88, green: 0.87, blue: 0.87, alpha: 1).cgColor
       }
    
    func formatTime(durationInSeconds: Int) -> String {
        let minutes = durationInSeconds / 60
        let seconds = durationInSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    func setData(lesson: Lessons) {
        lessonImageView.sd_setImage(with: URL(string: "http://45.12.74.158/" + lesson.image_src), placeholderImage: nil)
        lessonLabel.text = lesson.name
        descriptionLabel.text = lesson.title
        timeLabel.text = "\(lesson.duration / 60)"
        
        let durationInSeconds = lesson.duration
        let formattedTime = formatTime(durationInSeconds: durationInSeconds)
        timeLabel.text = formattedTime
    }
    
    @objc func addToFavorite() {
        var method = HTTPMethod.post
        if (lesson.favorite != 0) {
            method = .delete
        }
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.access_token)"
        ]
        
        let parameters = ["lesson_id": lesson.id] as [String : Any]
        
        AF.request(Urls.FAVORITE_URL, method: method,/* parameters: parameters,*/ encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                self.lesson.favorite = 1
                self.buttonsSettings()
            } else {
                var ErrorString = "CONNECTION_ERROR"
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    func buttonsSettings() {
        if (lesson.favorite == 1) {
            favoriteButton.setImage(UIImage(named: "favoriteSelectedLessons"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favoriteLessons"), for: .normal)
        }
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
