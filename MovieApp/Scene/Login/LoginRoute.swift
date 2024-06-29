//
//  LoginRoute.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol LoginRoute {
    func placeOnLoginViewController()
}

extension LoginRoute where Self: RouterProtocol {
    func placeOnLoginViewController() {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let loginViewController = LoginView(viewModel: viewModel, router: router)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        let transition = PlaceOnWindowTransition()
        router.presentingViewController = loginViewController
        open(navigationController, transition: transition)
    }
}
