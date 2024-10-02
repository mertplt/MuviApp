//
//  EditProfileRoute.swift
//  MovieApp
//
//  Created by Mert Polat on 02.09.24.
//


import UIKit

protocol EditProfileRoute {
    func placeOnEditProfileViewController()
}

extension EditProfileRoute where Self: RouterProtocol {
    func placeOnEditProfileViewController() {
        let editProfileViewController = EditProfileViewController()
        let transition = PushTransition()
        transition.viewController = presentingViewController
        open(editProfileViewController, transition: transition)
    }
}
