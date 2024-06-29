//
//  HomeView.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import UIKit
import TinyConstraints

class HomeView: UIViewController {
    
    var viewModel: HomeViewModel
    var router: HomeRouter
    
    init(viewModel: HomeViewModel, router: HomeRouter) {
        self.viewModel = viewModel
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
        button.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(testButton)
        view.backgroundColor = .white
        
        testButton.leadingToSuperview().constant = 24
        testButton.topToSuperview().constant = 50
    }
    
    @objc func testButtonTapped() {
        viewModel.testAction()
    }
}

#Preview {
    let router = HomeRouter()
    let viewModel = HomeViewModel(router: router)
    return HomeView(viewModel: viewModel, router: router)
}
