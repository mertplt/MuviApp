//
//  OnboardingRoute.swift
//  MovieApp
//
//  Created by mert polat on 10.03.2024.
//

//import UIKit
//
//protocol OnboardingRoute{
//    func placeOnOnboardingViewController()
//}
//
//extension OnboardingRoute where Self: RouterProtocol{
//    
//    func placeOnOnboardingViewController() {
//        
//        let router = OnboardingRouter()
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let loginViewController = OnboardingViewController(router: router)
//        let navigationController = UINavigationController(rootViewController: loginViewController)
//        let transition = PlaceOnWindowTransition()
//        router.presentingViewController = loginViewController
//        open(navigationController, transition: transition)
//    }
//}
