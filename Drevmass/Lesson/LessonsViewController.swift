//
//  ProductViewController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 20.11.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class LessonsViewController: UIViewController, LessonProtocol {
    
    var delegate : LessonProtocol?
    
    var lessons: [Lessons] = []
    
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
        downloadLessons()
        
        lessonsCollectionView.dataSource = self
        lessonsCollectionView.delegate = self
    }
}

//MARK: - Views & constraints
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
}
    
//MARK: - Functions
private extension LessonsViewController {
    @objc func profileVC() {
        let profileVC = ProfileViewController()
        profileVC.hidesBottomBarWhenPushed = true
        navigationController?.show(profileVC, sender: true)
        navigationItem.title = ""
    }
    
    func downloadLessons() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.access_token)"
        ]
        
        AF.request(Urls.LESSONS_URL, method: .get, headers: headers).responseData { response in
            
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
                        let lesson = Lessons(json: item)
                        self.lessons.append(lesson)
                    }
                    self.lessonsCollectionView.reloadData()
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

//MARK: - UICollectionViewDelegate & Data Source
extension LessonsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonsCell", for: indexPath) as! LessonsCollectionViewCell
        cell.setData(lesson: lessons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        lessonDidSelect(lesson: lessons[indexPath.row])
    }
}

//MARK: - LessonProtocol
extension LessonsViewController {
   
    func lessonDidSelect(lesson: Lessons) {
        let lessonInfoVC = LessonInfoViewController()
        lessonInfoVC.lesson = lesson
        navigationController?.show(lessonInfoVC, sender: self)
    }
}
