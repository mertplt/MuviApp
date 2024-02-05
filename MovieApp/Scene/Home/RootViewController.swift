//
//  RootViewController.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import UIKit
import TinyConstraints

class RootViewController: UIViewController {
    
    private let testButton: MaButton = {
        let button = MaButton()
        button.buttonTitle = "Login with Apple"
        button.style = .bigButtun
         return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testButton)
        view.backgroundColor = .white
        
        testButton.leadingToSuperview().constant = 24
        testButton.topToSuperview().constant = 50
    }


}

#Preview {
    RootViewController()
}

