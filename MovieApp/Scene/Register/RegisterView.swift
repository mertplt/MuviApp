//
//  RegisterView.swift
//  MovieApp
//
//  Created by mert polat on 23.02.2024.
//

import UIKit

class RegisterView: UIViewController {
    var registerViewModel: RegisterViewModel!
    var router: RegisterRouter
    
    init(router: RegisterRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        view.backgroundColor = .red
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
