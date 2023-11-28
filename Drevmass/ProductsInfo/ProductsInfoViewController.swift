//
//  ProductsInfoViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 26.11.2023.
//

import UIKit

class ProductsInfoViewController: UIViewController {
    
    var products = Products()
    
    private lazy var productScrollView = {
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
        label.text = "Тревел ролик"
        label.font = .appFont(ofSize: 22, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.text = "1 490₽"
        label.font = .appFont(ofSize: 22, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        label.textAlignment = .left
        return label
    }()
    
    private lazy var sizeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "sizeProduct")
        return iv
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "16 см х 8 см"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.textColor = .appMainBeige
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weightImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "weightProduct")
        return iv
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "300 гр"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.textColor = .appMainBeige
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Роликом за 10 минут можно эффективно и глубоко проработать ягодицы, заднюю часть бедра, стопы, спину: поясничный, грудной и шейный отдел. Для занятий рекомендуем использовать коврик для йоги и посмотреть методику по кнопке внизу."
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.numberOfLines = 0
        label.textColor = .appGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var howToUseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Как использовать?", for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        button.setTitleColor(.appWhite, for: .normal)
        button.configuration?.titleAlignment = .center
        button.addTarget(self, action: #selector(useButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 30
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setData()
    }
}

extension ProductsInfoViewController {
    
    func setupViews() {
        view.addSubviews(productScrollView, howToUseButton)
        productScrollView.addSubview(contentView)
        contentView.addSubviews(posterImage, backArrowButton, profileButton, backView)
        backView.addSubviews(nameLabel, costLabel, sizeImageView, sizeLabel, weightImageView, weightLabel, descriptionLabel)
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
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(272)
            make.bottom.right.left.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(110)
        }
        
        costLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(29)
        }
        
        sizeImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(24)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sizeImageView)
            make.left.equalTo(sizeImageView.snp.right).offset(8)
        }
        
        weightImageView.snp.makeConstraints { make in
            make.centerY.equalTo(sizeLabel)
            make.left.equalTo(sizeLabel.snp.right).offset(24)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weightImageView)
            make.left.equalTo(weightImageView.snp.right).offset(8)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeImageView.snp.bottom).offset(17)
            make.right.left.equalToSuperview().inset(24)
        }
        
        howToUseButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.right.left.equalToSuperview().inset(40)
            make.height.equalTo(70)
        }
    }
}

extension ProductsInfoViewController {
    
    @objc func profileVC() {
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = true
        navigationController?.show(profileVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc func backArrowButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func useButtonTapped() {
        let playerVC = PlayerViewController()
        playerVC.video_src = products.video_src
        
        navigationController?.show(playerVC, sender: true)
        navigationItem.title = ""
    }
    
    func setData() {
        posterImage.sd_setImage(with: URL(string: "http://45.12.74.158/" + products.image_src), completed: nil)
        
        nameLabel.text = products.name
        descriptionLabel.text = products.description
        costLabel.text = "\(products.price)₽"
        weightLabel.text = "\(products.weight)гр"
        sizeLabel.text = products.length + "см х " + products.height + "см"
    }
}
