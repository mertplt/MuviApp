//
//  ForgotPasswordRouter.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

    typealias ForgotPasswordRoutes = RegisterRoute & LoginRoute

final class ForgotPasswordRouter: Router, ForgotPasswordRoutes {    
    func navigateBack() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
}
