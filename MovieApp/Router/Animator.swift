//
//  Animator.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool {get set }
}
