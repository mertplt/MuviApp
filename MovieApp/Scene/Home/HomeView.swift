//
//  RootViewController.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import UIKit
import TinyConstraints

class HomeView: UIViewController {
    
    var router: HomeRouter
    init(router: HomeRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let testButton: MaButton = {
        let button = MaButton()
        button.buttonTitle = "Login with Apple"
        button.style = .bigButton
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
    HomeView(router: HomeRouter())
}
