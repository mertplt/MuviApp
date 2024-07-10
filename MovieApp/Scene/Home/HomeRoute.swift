//
//  HomeRoute.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol HomeRoute {
    func placeOnHomeViewController()
}

extension HomeRoute where Self: RouterProtocol {
    func placeOnHomeViewController() {
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router)
        let homeViewController = HomeView(viewModel: viewModel, router: router)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        let transition = PlaceOnWindowTransition()
        router.presentingViewController = homeViewController
        
        open(navigationController, transition: transition)
    }
}
