//
//  LessonInfoViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 26.11.2023.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON
import SVProgressHUD

class LessonInfoViewController: UIViewController {
    
    var lesson = Lessons()
    
    //MARK: - UI Elements
    private lazy var lessonScrollView = {
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
        
        imageView.image = .productInfo
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var backArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backArrowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.addTarget(self, action: #selector(profileVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playLessons"), for: .normal)
        button.alpha = 0.7
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Урок 2."
        label.font = .appFont(ofSize: 22, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        label.textAlignment = .left
        return label
    }()
    
    private lazy var timeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "timeIcon")
        return iv
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "3 мин"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.textColor = .appMainBeige
        label.textAlignment = .left
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteLessons"), for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Почему массажер Древмасс эффективен? Как правильно расставлять ролики и ложиться на массажер."
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        label.textColor = .appBrown
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Полная комплектация массажера Древмасс включает в себя: инструкцию, гарантийный талон, набор креплений, фиксатор для вертикального хранения, медицинский массажер Су Джок, воск для смазки осей, браслет на руку, тряпочка для протирки.   Наша цель – обеспечить людей доступным инструментом для поддержания здоровья позвоночника. Дать понимание, что здоровье спины это один из основных показателей комфорта жизни после 55. Чем раньше начать, тем комфортнее будет потом. Жить без боли просто с Древмасс»."
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        label.textColor = .appGray
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: Views & Constraints
extension LessonInfoViewController {
    func setupViews() {
        view.addSubviews(lessonScrollView)
        lessonScrollView.addSubview(contentView)
        contentView.addSubviews(posterImage, backArrowButton, profileButton, playButton, backView)
        backView.addSubviews(nameLabel, timeImageView, timeLabel, favoriteButton, titleLabel, subtitleLabel)
    }
    
    func setupConstraints() {
        
        posterImage.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(321)
        }
        
        backArrowButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        profileButton.snp.makeConstraints { make in
            make.centerY.equalTo(backArrowButton)
            make.right.equalToSuperview().inset(20)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(121)
            make.size.equalTo(CGSize(width: 78, height: 78))
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(272)
            make.bottom.right.left.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.left.equalToSuperview().inset(24)
        }
        
        timeImageView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(20)
            make.top.equalToSuperview().offset(29)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeImageView)
            make.left.equalTo(timeImageView.snp.right).offset(8)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(timeImageView)
            make.right.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeImageView.snp.bottom).offset(17)
            make.right.left.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.right.left.equalToSuperview().inset(24)
        }
    }
}

//MARK: Functions
extension LessonInfoViewController {
    
    @objc func profileVCTapped() {
        let profileVC = ProfileViewController()
        navigationController?.show(profileVC, sender: true)
        navigationItem.title = ""
    }
    
    func setData() {
        posterImage.sd_setImage(with: URL(string: "http://45.12.74.158/" + lesson.image_src), completed: nil)
        timeLabel.text = "\(lesson.duration / 60) мин"
        nameLabel.text = lesson.name
        titleLabel.text = lesson.title
        subtitleLabel.text = lesson.description
    }
    
    @objc func addToFavorite() {
        var method = HTTPMethod.post
        let action = "add"
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.access_token)"
        ]
        
        let parameters: [String : Any] = ["lesson_id": 2, "action": action]
        AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
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
    
    @objc func playButtonTapped() {
        let playerVC = PlayerViewController()
        playerVC.video_src = lesson.video_src
        
        navigationController?.show(playerVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc func profileVC() {
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = true
        navigationController?.show(profileVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc func backArrowButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

