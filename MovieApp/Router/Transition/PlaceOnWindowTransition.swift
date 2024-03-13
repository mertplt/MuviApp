//
//  PlaceOnWindowTransition.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

class PlaceOnWindowTransition: Transition{
    
    var  viewController: UIViewController?
    
    func open(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first else {return}
        
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations:{ UIView.performWithoutAnimation {
            window.rootViewController = viewController
        }
        }, completion: nil)
    }
        func close(_ viewController: UIViewController) {}

}
