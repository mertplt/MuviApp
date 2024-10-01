//
//  ForgotPasswordView.swift
//  MovieApp
//
//  Created by mert polat on 6.03.2024.
//

import UIKit

final class ForgotPasswordView: UIViewController {
    
    private let viewModel: ForgotPasswordViewModel
    private let router: ForgotPasswordRouter
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(.arrowLeft, for: .normal)
        return button
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.font = FontManager.headline1()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm your email and we’ll send\nthe instructions."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = FontManager.paragraphAndButton()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    private let emailTextField: MaTextField = {
        let textField = MaTextField()
        textField.style = .email
        return textField
    }()
    
    private let emailLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    private let resetPasswordButton: MaButton = {
        let button = MaButton()
        button.style = .largeButtonYellow
        button.buttonTitle = "Reset Password"
        return button
    }()
    
    init(viewModel: ForgotPasswordViewModel, router: ForgotPasswordRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureUI()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func configureUI() {
        view.backgroundColor = ColorManager.surfaceDark
        
        [mainLabel, descriptionLabel, emailTextField, emailLineView, resetPasswordButton].forEach {
            view.addSubview($0)
        }
        
        layoutUI()
    }
    
    private func layoutUI() {
        mainLabel.topToSuperview(offset: 127)
        mainLabel.centerX(to: view)
        
        descriptionLabel.topToBottom(of: mainLabel, offset: 9)
        descriptionLabel.leading(to: mainLabel)
        
        emailTextField.leadingToSuperview(offset: 20)
        emailTextField.topToBottom(of: descriptionLabel, offset: 24)
        
        emailLineView.topToBottom(of: emailTextField, offset: 0)
        emailLineView.leading(to: emailTextField)
        emailLineView.trailing(to: emailTextField)
        
        resetPasswordButton.topToBottom(of: emailTextField, offset: 40)
        resetPasswordButton.centerX(to: view)
    }
    
    @objc private func backButtonTapped() {
        router.navigateBack()
    }
}
