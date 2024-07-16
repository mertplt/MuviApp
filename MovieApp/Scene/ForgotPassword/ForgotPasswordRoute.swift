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
        let viewModel = ForgotPasswordViewModel(router: router)
        let forgotPasswordVC = ForgotPasswordView(viewModel: viewModel, router: router)
        let transition = PushTransition()
        
        router.presentingViewController = forgotPasswordVC
        open(forgotPasswordVC, transition: transition)
    }
}
