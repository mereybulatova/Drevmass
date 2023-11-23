//
//  TabBarController.swift
//  Drevmass
//
//  Created by Мерей Булатова on 20.11.2023.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    var lineView = {
        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        setTabBarAppearance()
        tabBarLine()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let tabBarHeight: CGFloat = 86

        tabBar.frame.size.height = tabBarHeight
        tabBar.frame.origin.y = view.bounds.maxY - tabBarHeight
    }

    private func setUpTabs() {
        let productVC = ProductViewController()
        productVC.tabBarItem.title = "Товары"
        productVC.tabBarItem.image = UIImage(named: "productTabBar")
        
        let lessonsVC = LessonsViewController()
        lessonsVC.tabBarItem.title = "Уроки"
        lessonsVC.tabBarItem.image = UIImage(named: "videoTabBar")
            
        let favoriteVC = FavoritesViewController()
        favoriteVC.tabBarItem.title = "Избранное"
        favoriteVC.tabBarItem.image = UIImage(named: "favoriteTabBar")
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "favoriteSelectedTabBar")
           
        let navProductVC = UINavigationController(rootViewController: productVC)
        let navLessonsVC = UINavigationController(rootViewController: lessonsVC)
        let navFavoriteVC = UINavigationController(rootViewController: favoriteVC)
        
        setViewControllers([navProductVC, navLessonsVC, navFavoriteVC], animated: true)
    }
    
    private func setTabBarAppearance() {
        tabBar.backgroundColor = UIColor.appBrown
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
    }
    
    private func tabBarLine() {
        let tabBarHeight = tabBar.frame.size.height
                let tabBarWidth = tabBar.frame.size.width / CGFloat(viewControllers?.count ?? 1)
                let initialX = tabBarWidth * CGFloat(selectedIndex)
                
                lineView = UIView(frame: CGRect(x: initialX, y: 0, width: tabBarWidth, height: 4))
                lineView.backgroundColor = UIColor.appBeige
                tabBar.addSubview(lineView)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let items = tabBar.items, let selectedItem = items.firstIndex(of: item) else {
            return
        }

        let tabBarWidth = tabBar.frame.size.width / CGFloat(items.count)
        let newX = tabBarWidth * CGFloat(selectedItem)
        
        UIView.animate(withDuration: 0.3) {
            self.lineView.frame.origin.x = newX
        }
    }
}
