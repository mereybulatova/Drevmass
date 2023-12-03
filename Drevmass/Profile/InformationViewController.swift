//
//  InformationViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 24.11.2023.
//

import UIKit

class InformationViewController: UIViewController {
    
    //MARK: - UI Elements

    private lazy var mainInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Основные понятия"
        label.font = .appFont(ofSize: 22, weight: .regular, font: .Rubik)
        label.textColor = .appBrown
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = " - Посетитель Сайта — лицо, пришедшее на сайт https://drevmass.ru без цели размещения Заказа. - Пользователь — физическое лицо, посетитель Сайта, принимающий условия настоящего Соглашения и желающий разместить Заказы в Интернет-магазине drevmass.ru - Покупатель — Пользователь, разместивший Заказ в Интернет-магазине drevmass.ru - Продавец — drevmass.ru или иное юридическое лицо либо индивидуальный предприниматель, товар которых размещен в Интернет-магазине. - Иные продавцы – юридические лица или индивидуальные предприниматели, реализующие Товары drevmass.ru на сторонних интернет-магазинах с согласия drevmass.ru - Интернет-магазин — Интернет-сайт, принадлежащий drevmass.ru, расположенный в сети интернет по адресу https://drevmass.ru"
        label.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        label.textColor = .appBrown
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
private extension InformationViewController {
    
    func setupViews() {
        navigationItem.title = "Правовая информация"
        
        view.backgroundColor = .appWhite
        view.addSubviews(mainInfoLabel, infoLabel)
    }
    
    func setupConstraints() {
        mainInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainInfoLabel.snp.bottom).offset(21)
            make.left.right.equalToSuperview().inset(24)
        }
    }
}
