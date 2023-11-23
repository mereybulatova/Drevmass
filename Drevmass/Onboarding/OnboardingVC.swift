//
//  OnboardingVC.swift
//  Drevmass
//
//  Created by Мерей Булатова on 21.11.2023.
//

import UIKit
import SnapKit
import AdvancedPageControl

struct OnboardingSlide {
    let logo: UIImage
    let title: String
    let description: String
    let image: UIImage
}

class OnboardingVC: UIViewController {
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide(
            logo: .logoOnboarding,
            title: "Избавьтесь от боли в спине раз и навсегда!",
            description: "Здоровье спины – этo один из основных показателей комфорта жизни.",
            image: .onboarding1
        ),
        OnboardingSlide(
            logo: .logoOnboarding,
            title: "Наша цель",
            description: "Обеспечить людей доступным инструментом для поддержания здоровья позвоночника.",
            image: .onboarding2
        ),
        OnboardingSlide(
            logo: .logoOnboarding,
            title: "Спина требует ежедневного ухода!",
            description: "Мы с вами научимся заниматься на тренажере-массажере для спины Древмасс.",
            image: .onboarding3
        ),
        OnboardingSlide(
            logo: .logoOnboarding,
            title: "Давай вместе заботиться о здоровье!",
            description: "Чтобы начать заниматься, вам необходимо зарегистрироваться или войти в аккаунт.",
            image: .onboarding4
        ),
    ]
    
    //MARK: - UI Elements
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(.appGray, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.appBeige, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 16, weight: .light, font: .Rubik)
        
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var pageControl: AdvancedPageControlView = {
        let pageControl = AdvancedPageControlView()

        pageControl.drawer = ColorBlendDrawer(
            numberOfPages: slides.count,
            height: 8,
            width: 8,
            space: 12,
            raduis: 5,
            indicatorColor: .appGray,
            dotsColor: .appLightGray
        )
        return pageControl
    }()
    
    private lazy var backCellButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backArrowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appBeige
        button.setTitle("Зарегистрироваться", for: .normal)
        button.tintColor = .appWhite
        button.configuration?.titleAlignment = .center
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var slidesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)

        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = collectionView.bounds.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = .zero

        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false

        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "Cell")

        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

    //MARK: - Set up views

private extension OnboardingVC {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubviews(slidesCollectionView, skipButton, loginButton, pageControl, backCellButton, signUpButton)
    }

    func setupConstraints() {
        slidesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(88)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(loginButton)
            make.size.equalTo(CGSize(width: 78, height: 8))
        }
        
        backCellButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 46, height: 46))
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 296, height: 56))
            make.bottom.equalToSuperview().inset(60)
        }
    }
}

    //MARK: - UI Collection View

extension OnboardingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath
        ) as? OnboardingCell else {
            fatalError("Unsupported")
        }
        
        cell.setData(with: slides[indexPath.row])
        
        return cell
    }
    
    //MARK: - Page control
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let currentPage = Int(round(offSet / width))
        
        pageControl.setPage(currentPage)
        
        if currentPage == 0 {
            backCellButton.layer.opacity = 0
            backCellButton.isHidden = true
        } else {
            backCellButton.layer.opacity = 1
            backCellButton.isHidden = false
        }
        
        signUpButton.layer.opacity = currentPage == 3 ? 1 : 0
        signUpButton.isHidden = currentPage != 3
    }
}

        //MARK: - Add objc functions

extension OnboardingVC {
    
    @objc func skipButtonTapped() {
        let offsetX = CGFloat(4) * slidesCollectionView.frame.width
        let contentSize = CGSize(width: offsetX + slidesCollectionView.frame.width, height: slidesCollectionView.frame.height)
        
        slidesCollectionView.contentSize = contentSize
        navigationController?.navigationBar.isHidden = true
        slidesCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc func loginButtonTapped() {
        let loginVC = SignInViewController()
        navigationController?.show(loginVC, sender: true)
        navigationItem.title = ""
    }
    
    @objc func backArrowTapped() {
        let offSet = slidesCollectionView.contentOffset.x
        let width = slidesCollectionView.frame.width
        let currentIndex = Int(round(offSet / width))
        
        let contentSize = CGSize(width: offSet + slidesCollectionView.frame.width, height: slidesCollectionView.frame.height)
        let previousIndex = max(0, currentIndex - 1)
        let offsetX = CGFloat(previousIndex) * slidesCollectionView.frame.width
        
        slidesCollectionView.contentSize = contentSize
        slidesCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.show(signUpVC, sender: true)
        navigationItem.title = ""
    }
}

