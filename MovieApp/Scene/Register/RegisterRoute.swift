//
//  RegisterRoute.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol RegisterRoute {
    func pushRegisterViewController()
    func presentRegisterViewController()
    func placeOnRegisterViewController()
}

extension RegisterRoute where Self: RouterProtocol {
    
    func pushRegisterViewController() {
        let router = RegisterRouter()
        let viewModel = RegisterViewModel(router: router)
        let registerViewController = RegisterView(viewModel: viewModel, router: router)
        router.presentingViewController = registerViewController
        let transition = ModalTransition(modalTransitionStyle: .crossDissolve, modalPresentationStyle: .fullScreen)
        open(registerViewController, transition: transition)
    }
    
    func presentRegisterViewController() {
        let router = RegisterRouter()
        let viewModel = RegisterViewModel(router: router)
        let registerViewController = RegisterView(viewModel: viewModel, router: router)
        router.presentingViewController = registerViewController
        let transition = ModalTransition(modalTransitionStyle: .crossDissolve, modalPresentationStyle: .fullScreen)
        open(registerViewController, transition: transition)
    }
    
    func placeOnRegisterViewController() {
        let router = RegisterRouter()
        let viewModel = RegisterViewModel(router: router)
        let registerViewController = RegisterView(viewModel: viewModel, router: router)
        let navigationController = UINavigationController(rootViewController: registerViewController)
        let transition = PlaceOnWindowTransition()
        router.presentingViewController = registerViewController
        open(navigationController, transition: transition)
    }
}
