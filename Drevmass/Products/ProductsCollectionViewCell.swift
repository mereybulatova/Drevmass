//
//  ProductsCollectionViewCell.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    public let identifier = "ProductsCell"
      
      //MARK: - UI Elements
      
      private lazy var titleLabel: UILabel = {
          let label = UILabel()
          label.text = "Для стоп и тела"
          label.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
          label.textColor = .appBrown
          label.textAlignment = .left
          
          return label
      }()
      
      private lazy var productImageView: UIImageView = {
          let iv = UIImageView()
          iv.image = UIImage(named: "product")
          iv.layer.cornerRadius = 10
          iv.clipsToBounds = true
          
          return iv
      }()
      
      private lazy var costLabel: UILabel = {
          let label = UILabel()
          label.text = "2 000R"
          label.font = .appFont(ofSize: 18, weight: .regular, font: .Rubik)
          label.textColor = .appWhite
          label.textAlignment = .center
          label.backgroundColor = .appBeige
          label.layer.cornerRadius = 20
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

  private extension ProductsCollectionViewCell {
      func commonInit() {
          layer.cornerRadius = 35
          layer.borderWidth = 1
          layer.borderColor = UIColor(red: 0.88, green: 0.87, blue: 0.87, alpha: 1).cgColor
      }
      
      func setupViews() {
          contentView.backgroundColor = .appWhite
          contentView.addSubviews(titleLabel, productImageView, costLabel)
      }
      
      func setupConstraints() {
          titleLabel.snp.makeConstraints { make in
              make.top.equalToSuperview().offset(24)
              make.leading.equalToSuperview().inset(24)
          }
        
          productImageView.snp.makeConstraints { make in
              make.top.equalTo(titleLabel.snp.bottom).offset(16)
              make.trailing.leading.bottom.equalToSuperview().inset(8)
          }
          
          costLabel.snp.makeConstraints { make in
              make.leading.bottom.equalToSuperview().inset(24)
              make.size.equalTo(CGSize(width: 95, height: 39))
          }
      }
  }
