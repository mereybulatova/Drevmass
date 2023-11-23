//
//  FavoritesViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 20.11.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    //MARK: - UI Elements

    private lazy var favoriteCollectionView: UICollectionView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
    }
}

private extension FavoritesViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(favoriteCollectionView)
        
        navigationItem.title = "Избранные уроки"
        navigationController?.setDefaultNavigationBarAppearance()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(profileVC))
        tabBarController?.tabBar.barTintColor = .appBrown
    }
    
    func setupConstraints() {
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.right.left.equalToSuperview()
        }
    }
    
    @objc func profileVC() {
        
    }
}

     //MARK: - UICollectionViewDelegate & Data Source

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonsCell", for: indexPath) as! LessonsCollectionViewCell
        
        return cell
    }
}

