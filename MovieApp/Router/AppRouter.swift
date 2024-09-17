//
//  AppRouter.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit
import FirebaseAuth

typealias AppRoutes = FirstOnboardingRoute & TabBarRoute

final class AppRouter: Router, AppRoutes {
    
    static let shared = AppRouter()
    
    func startApp() {
        if Auth.auth().currentUser != nil {
            pushTabBarViewController()
        } else {
            placeOnFirstOnboardingViewController()
        }
    }
}
