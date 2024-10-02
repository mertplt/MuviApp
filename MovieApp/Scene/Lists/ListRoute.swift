//
//  ListRoute.swift
//  MovieApp
//
//  Created by Mert Polat on 04.09.24.
//

protocol ListRoute {
    func placeOnListViewController()
}

extension ListRoute where Self: RouterProtocol {
    func placeOnListViewController() {
        let listViewController = ListView()
        let transition = PushTransition()
        transition.viewController = presentingViewController
        open(listViewController, transition: transition)
    }
}
