//
//  HomeRouter.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

import UIKit

protocol HomeRoutes: AnyObject {
    typealias Routes = RegisterRoute & LoginRoute
}

final class HomeRouter: Router, HomeRoutes {
}
