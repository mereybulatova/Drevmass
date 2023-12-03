//
//  LessonsViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 20.11.2023.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

protocol ProductsProtocol {
    func productDidSelect(product: Products)
}

class ProductsViewController: UIViewController, ProductsProtocol {
    
    var products: [Products] = []
    
    //MARK: - UI Elements
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 328, height: 255)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "ProductsCell")
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
        downloadProducts()
        
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }
}

//MARK: - Views & Constraints
private extension ProductsViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(productsCollectionView)
        
        navigationItem.title = "Массажеры и аксессуары"
        navigationController?.setDefaultNavigationBarAppearance()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: #selector(profileVC))
        tabBarController?.tabBar.barTintColor = .appBrown
    }
    
    func setupConstraints() {
        productsCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.right.left.equalToSuperview()
        }
    }
}
    
//MARK: - Functions
private extension ProductsViewController {
    @objc func profileVC() {
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = true
        navigationController?.show(profileVC, sender: true)
        navigationItem.title = ""
    }
    
    func downloadProducts() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.access_token)"
        ]
        
        AF.request(Urls.PRODUCTS_URL, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let product = Products(json: item)
                        self.products.append(product)
                    }
                    self.productsCollectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                }
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
}

//MARK: - UICollectionViewDelegate & DataSource
extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCollectionViewCell
        cell.setData(product: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        productDidSelect(product: products[indexPath.row])
    }
}

//MARK: - ProductsProtocol
extension ProductsViewController {
    
    func productDidSelect(product: Products) {
        let productVC = ProductsInfoViewController()
        productVC.products = product
        navigationItem.title = ""
        navigationController?.show(productVC, sender: self)
    }
}
