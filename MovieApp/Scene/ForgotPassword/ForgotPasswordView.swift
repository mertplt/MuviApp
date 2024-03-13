//
//  ForgotPasswordView.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

class ForgotPasswordView: UIViewController {
    
    var router: ForgotPasswordRouter
    
    init(router: ForgotPasswordRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
