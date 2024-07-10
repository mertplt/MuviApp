//
//  Router.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol RouterProtocol: AnyObject {
    var presentingViewController: UIViewController? { get set }
    func open(_ viewController: UIViewController, transition: Transition)
    func close()
    func push(_ viewController: UIViewController)
    func present(_ viewController: UIViewController)
}

extension RouterProtocol {
    func push(_ viewController: UIViewController) {
        presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ viewController: UIViewController) {
        presentingViewController?.present(viewController, animated: true, completion: nil)
    }
}

class Router: RouterProtocol {
    weak var presentingViewController: UIViewController?
    var openTransition: Transition?
    
    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.presentingViewController
        transition.open(viewController)
    }
    
    func close() {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = presentingViewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController)
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
    
    func push(_ viewController: UIViewController) {
        presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ viewController: UIViewController) {
        presentingViewController?.present(viewController, animated: true, completion: nil)
    }
}
