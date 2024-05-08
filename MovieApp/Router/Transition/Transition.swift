//
//  Transition.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol Transition: AnyObject{
    var viewController: UIViewController? {get set}
    func open (_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
    
}
