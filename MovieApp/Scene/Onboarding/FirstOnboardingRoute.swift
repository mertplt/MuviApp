//
//  FirstOnboardingRoute.swift
//  MovieApp
//
//  Created by mert polat on 10.03.2024.
//

import UIKit

protocol FirstOnboardingRoute{
    func placeOnFirstOnboardingViewController()
}

extension FirstOnboardingRoute where Self: RouterProtocol{
    
    func placeOnFirstOnboardingViewController() {
        
        let router = FirstOnboardingRouter()
        let loginViewController = FirstOnboardingViewController(router: router)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        let transition = PlaceOnWindowTransition()
        router.presentingViewController = loginViewController
        open(navigationController, transition: transition)
    }
}
