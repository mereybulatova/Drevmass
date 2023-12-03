//
//  OnboardingCell.swift
//  Drevmass
//
//  Created by Мерей Булатова on 21.11.2023.
//

import Foundation
import UIKit

class OnboardingCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    public static let identifier = "Cell"
    
    //MARK: - UI Elements
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .appFont(ofSize: 24, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .appFont(ofSize: 18, weight: .light, font: .Rubik)
        label.textColor = .appBrown
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var slidesImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(with slide: OnboardingSlide) {
        logoImage.image = slide.logo
        titleLabel.text = slide.title
        subtitleLabel.text = slide.description
        slidesImage.image = slide.image
    }
}

//MARK: - Set up views

private extension OnboardingCell {    
    func setupViews() {
        contentView.addSubviews(slidesImage, logoImage, titleLabel, subtitleLabel)
        contentView.backgroundColor = .appOnboardingWhite
    }
    
    func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview().inset(24)
        }
        
        slidesImage.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
    }
}
