//
//  HomeRoute.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol HomeRoute {
    func placeOnMainVC()
}

extension HomeRoute where Self: RouterProtocol {
    func placeOnMainVC() {
        let router = HomeRouter()
        let mainViewController = HomeView(router: router)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        let transition = PlaceOnWindowTransition()
//        mainViewController.notesTableView.reloadData()
        router.presentingViewController = mainViewController
        
        open(navigationController, transition: transition)
        
    }
}
