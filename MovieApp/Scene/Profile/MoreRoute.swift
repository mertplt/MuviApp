//
//  MoreRoute.swift
//  MovieApp
//
//  Created by Mert Polat on 02.09.24.
//

import UIKit

protocol MoreRoute {
    func placeOnMoreViewController()
}

extension MoreRoute where Self: RouterProtocol {
    func placeOnMoreViewController() {
        let moreViewController = MoreView()
        let transition = PushTransition()
        transition.viewController = presentingViewController
        open(moreViewController, transition: transition)
    }
}
