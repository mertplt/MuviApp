//
//  AppRouter.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = LoginRoute
    
    static let shared = AppRouter()
    
    func startApp(){
        placeOnLoginViewController()
    }
}

