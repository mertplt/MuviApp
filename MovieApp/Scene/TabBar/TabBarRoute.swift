//
//  TabBarRoute.swift
//  MovieApp
//
//  Created by Mert Polat on 09.08.24.
//

import UIKit

protocol TabBarRoute {
    func pushTabBarViewController()
}

extension TabBarRoute where Self: RouterProtocol {
    func pushTabBarViewController() {
        let router = TabBarRouter()
        let viewController = MainTabBarViewController(router: router)
        let transition = PushTransition()
        
        router.presentingViewController = viewController
        open(viewController, transition: transition)
    }
}
