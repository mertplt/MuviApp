//
//  MainTabBarViewController.swift
//  MovieApp
//
//  Created by Mert Polat on 30.06.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router)
        
        tabBar.barTintColor = UIColor.black // Tab bar arka plan rengi
        tabBar.tintColor = ColorManager.primary // Seçilen item rengi
        tabBar.unselectedItemTintColor = ColorManager.highEmphasis // Seçilmeyen item rengi
        
        let vc1 = UINavigationController(rootViewController: HomeView(viewModel: viewModel, router: router))
        let vc2 = UINavigationController(rootViewController: SearchView())
        let vc3 = UINavigationController(rootViewController: ListView())
        let vc4 = UINavigationController(rootViewController: ProfileView())
        
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.tabBarItem.image = UIImage(named: "search")
        vc3.tabBarItem.image = UIImage(named: "folder")
        vc4.tabBarItem.image = UIImage(named: "grid")
        
        vc1.title = "Home"
        vc2.title = "Top Search"
        vc3.title = "Lists"
        vc4.title = "Profile"
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
}
