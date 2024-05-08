//
//  RegisterRoute.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol RegisterRoute {
    func placeOnRegisterViewController()
}

extension RegisterRoute where Self: RouterProtocol {
    
    func placeOnRegisterViewController() {
        let router = RegisterRouter()
        let registerViewController = RegisterView(router: router)
        let navigationController = UINavigationController(rootViewController: registerViewController)
        let transition = PlaceOnWindowTransition()
        router.presentingViewController = registerViewController
        open(navigationController, transition: transition)
    }
}
