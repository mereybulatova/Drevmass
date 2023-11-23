//
//  ProductViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 20.11.2023.
//

import UIKit

class LessonsViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var lessonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 328, height: 316)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LessonsCollectionViewCell.self, forCellWithReuseIdentifier: "LessonsCell")
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        lessonsCollectionView.dataSource = self
        lessonsCollectionView.delegate = self
    }
}

    //MARK: - Add views & constraints

private extension LessonsViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(lessonsCollectionView)
        
        navigationItem.title = "Обучающие уроки"
        navigationController?.setDefaultNavigationBarAppearance()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(profileVC))
        tabBarController?.tabBar.barTintColor = .appBrown
    }
    
    func setupConstraints() {
        lessonsCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.right.left.equalToSuperview()
        }
    }
    
    @objc func profileVC() {
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(profileVC, animated: true)
        navigationController?.show(profileVC, sender: true)
        navigationItem.title = ""
    }
}

     //MARK: - UICollectionViewDelegate & Data Source

extension LessonsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonsCell", for: indexPath) as! LessonsCollectionViewCell
        
        return cell
    }    
}
