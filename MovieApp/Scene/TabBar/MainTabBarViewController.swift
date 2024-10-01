//
//  MainTabBarViewController.swift
//  MovieApp
//
//  Created by Mert Polat on 30.06.2024.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    var router: TabBarRouter
    
    init(router: TabBarRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        setupViewControllers()
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = ColorManager.dark
        tabBar.tintColor = ColorManager.primary
        tabBar.unselectedItemTintColor = ColorManager.highEmphasis
        self.navigationItem.hidesBackButton = true
    }

    private func setupViewControllers() {
        let homeRouter = HomeRouter()
        let homeViewModel = HomeViewModel(router: homeRouter)
        
        let homeVC = UINavigationController(rootViewController: HomeView(viewModel: homeViewModel, router: homeRouter))
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let listVC = UINavigationController(rootViewController: ListView())
        let profileVC = UINavigationController(rootViewController: MoreView())
        
        homeVC.tabBarItem.image = UIImage(named: "home")
        searchVC.tabBarItem.image = UIImage(named: "search")
        listVC.tabBarItem.image = UIImage(named: "folder")
        profileVC.tabBarItem.image = UIImage(named: "grid")
        
        homeVC.title = "Home"
        searchVC.title = "Search"
        listVC.title = "Lists"
        profileVC.title = "Profile"
        
        setViewControllers([homeVC, searchVC, listVC, profileVC], animated: true)
    }
}
