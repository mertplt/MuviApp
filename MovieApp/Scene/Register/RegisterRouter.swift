//
//  RegisterRouter.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

final class RegisterRouter: Router, RegisterRouter.Routes {
    typealias Routes = LoginRoute & ForgotPasswordRoute & TabBarRoute
}
