//
//  RegisterView.swift
//  MovieApp
//
//  Created by mert polat on 23.02.2024.
//

import UIKit

class RegisterView: UIViewController {
    var registerViewModel: RegisterViewModel
    var router: RegisterRouter
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = FontManager.headline1()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter information below or login with social\naccount to get started"
        label.textAlignment = .left
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
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    private let passwordTextField: MaTextField = {
        let textField = MaTextField()
        textField.style = .password
        return textField
    }()
    
    private let passwordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    private let confirmPasswordTextField: MaTextField = {
        let textField = MaTextField()
        textField.style = .password
        textField.placeholderText = "Confirm Password"
        return textField
    }()
    
    private let confirmPasswordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(.arrowLeft, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let orContinueWithLabel: UILabel = {
        let label = UILabel()
        label.text = "or continue with"
        label.textColor = ColorManager.highEmphasis
        label.font = FontManager.paragraphAndButton()
        return label
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(.google, for: .normal)
        button.backgroundColor = UIColor(white: 0.2, alpha: 1)
        button.size(CGSize(width: 44, height: 44))
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(.facebook1, for: .normal)
        button.backgroundColor = UIColor(white: 0.2, alpha: 1)
        button.size(CGSize(width: 44, height: 44))
        return button
    }()
    
    private let registerButton: MaButton = {
        let button = MaButton()
        button.style = .largeButtonYellow
        button.buttonTitle = "Register"
        return button
    }()
    
    init(viewModel: RegisterViewModel, router: RegisterRouter) {
        self.registerViewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupActions()
    }
    
    private func configureUI() {
        view.backgroundColor = ColorManager.surfaceDark
        
        [mainLabel, descriptionLabel, emailTextField, emailLineView, passwordTextField, passwordLineView, confirmPasswordTextField, confirmPasswordLineView, backButton, orContinueWithLabel, googleButton, facebookButton, registerButton].forEach {
            view.addSubview($0)
        }
        layoutUI()
    }
    
    private func layoutUI() {
        mainLabel.topToSuperview(offset: 127)
        mainLabel.leftToSuperview(offset: 20)
        
        descriptionLabel.topToBottom(of: mainLabel, offset: 9)
        descriptionLabel.left(to: mainLabel)
        
        emailTextField.leadingToSuperview(offset: 20)
        emailTextField.topToBottom(of: descriptionLabel, offset: 24)
        
        emailLineView.topToBottom(of: emailTextField)
        emailLineView.leading(to: emailTextField)
        emailLineView.trailing(to: emailTextField)
        
        passwordTextField.topToBottom(of: emailLineView, offset: 15)
        passwordTextField.leading(to: emailTextField)
        passwordTextField.trailing(to: emailTextField)
        
        passwordLineView.topToBottom(of: passwordTextField)
        passwordLineView.leading(to: passwordTextField)
        passwordLineView.trailing(to: passwordTextField)
        
        confirmPasswordTextField.topToBottom(of: passwordLineView, offset: 15)
        confirmPasswordTextField.leading(to: passwordTextField)
        confirmPasswordTextField.trailing(to: passwordTextField)
        
        confirmPasswordLineView.topToBottom(of: confirmPasswordTextField)
        confirmPasswordLineView.leading(to: confirmPasswordTextField)
        confirmPasswordLineView.trailing(to: confirmPasswordTextField)
        
        orContinueWithLabel.topToBottom(of: confirmPasswordTextField, offset: 40)
        orContinueWithLabel.leadingToSuperview(offset: 20)
        
        googleButton.topToBottom(of: orContinueWithLabel, offset: 15)
        googleButton.leading(to: orContinueWithLabel)
        
        facebookButton.top(to: googleButton)
        facebookButton.leadingToTrailing(of: googleButton, offset: 16)
        
        registerButton.bottomToSuperview(offset: -70)
        registerButton.centerX(to: view)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
    }
    
    private func setupActions() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        router.placeOnLoginViewController()
    }
    
    @objc private func registerButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        registerViewModel.register(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    @objc private func googleButtonTapped() {
        registerViewModel.signInWithGoogle(presenting: self)
    }
}
