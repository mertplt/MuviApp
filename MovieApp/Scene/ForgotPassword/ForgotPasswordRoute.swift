//
//  ForgotPasswordRoute.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol ForgotPasswordRoute {
    func pushForgotPasswordViewController()
}

extension ForgotPasswordRoute where Self: RouterProtocol {
    
    func pushForgotPasswordViewController() {
        let router = ForgotPasswordRouter()
        let forgotPasswordVC = ForgotPasswordView(router: router)
        let transition = PushTransition()
        
        router.presentingViewController = forgotPasswordVC

        open(forgotPasswordVC, transition: transition)
    }
}
