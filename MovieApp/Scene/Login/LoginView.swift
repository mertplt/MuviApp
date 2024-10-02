//
//  LoginView.swift
//  MovieApp
//
//  Created by mert polat on 16.02.2024.
//

import UIKit
import TinyConstraints

final class LoginView: UIViewController {
    private let viewModel: LoginViewModel
    private let router: LoginRouter

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .loginBackground
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.headline1()
        label.text = "Login"
        label.textColor = ColorManager.surfaceLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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
        textField.autocapitalizationType = .none
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
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.backgroundColor = ColorManager.surfaceDark
        button.setTitleColor(ColorManager.disabled, for: .normal)
        button.titleLabel?.font = FontManager.caption()
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up now", for: .normal)
        button.backgroundColor = ColorManager.surfaceDark
        button.setTitleColor(ColorManager.primary, for: .normal)
        button.titleLabel?.font = FontManager.paragraphAndButton()
        return button
    }()
    
    private let orContinueWithLabel: UILabel = {
        let label = UILabel()
        label.text = "or continue with"
        label.textColor = ColorManager.highEmphasis
        label.backgroundColor = ColorManager.surfaceDark
        label.font = FontManager.paragraphAndButton()
        return label
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(.google, for: .normal)
        button.backgroundColor = UIColor(red: 0.176, green: 0.186, blue: 0.2, alpha: 1)
        button.size(CGSize(width: 44, height: 44))
        return button
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(.facebook1, for: .normal)
        button.backgroundColor = UIColor(red: 0.176, green: 0.186, blue: 0.2, alpha: 1)
        button.size(CGSize(width: 44, height: 44))
        return button
    }()
    
    private let loginButton: MaButton = {
        let button = MaButton()
        button.style = .largeButtonYellow
        button.buttonTitle = "Login"
        return button
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Not registered?"
        label.textColor = ColorManager.disabled
        label.font = FontManager.paragraphAndButton()
        return label
    }()
    
    init(viewModel: LoginViewModel, router: LoginRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupAction()
    }
    
    private func configureUI() {
        view.backgroundColor = ColorManager.surfaceDark
        [backgroundImageView, titleLabel, emailTextField, emailLineView, passwordTextField, passwordLineView, forgotPasswordButton, orContinueWithLabel, googleButton, facebookButton, loginButton, registerButton, registerLabel].forEach {
            view.addSubview($0)
        }
        
        layoutUI()
    }
    
    private func layoutUI() {
        backgroundImageView.topToSuperview(offset: 0)
        backgroundImageView.leadingToSuperview(offset: 0)
        backgroundImageView.trailingToSuperview(offset: 0)
        
        titleLabel.leadingToSuperview(offset: 20)
        titleLabel.topToSuperview(offset: 395)
        
        emailTextField.leadingToSuperview(offset: 20)
        emailTextField.topToBottom(of: titleLabel, offset: 25)
        
        emailLineView.topToBottom(of: emailTextField, offset: 0)
        emailLineView.leading(to: emailTextField)
        emailLineView.trailing(to: emailTextField)
        
        passwordTextField.topToBottom(of: emailLineView, offset: 15)
        passwordTextField.leading(to: emailTextField)
        passwordTextField.trailing(to: emailTextField)
        
        passwordLineView.topToBottom(of: passwordTextField, offset: 0)
        passwordLineView.leading(to: passwordTextField)
        passwordLineView.trailing(to: passwordTextField)
        
        forgotPasswordButton.topToBottom(of: passwordLineView, offset: 16)
        forgotPasswordButton.trailingToSuperview(offset: 21)
        forgotPasswordButton.leadingToSuperview(offset: 253)
        
        orContinueWithLabel.topToBottom(of: forgotPasswordButton, offset: 16)
        orContinueWithLabel.leadingToSuperview(offset: 20)
        
        googleButton.topToBottom(of: orContinueWithLabel, offset: 15)
        googleButton.leading(to: orContinueWithLabel)
        
        facebookButton.top(to: googleButton)
        facebookButton.leadingToTrailing(of: googleButton, offset: 16)
        
        loginButton.bottomToSuperview(offset: -70)
        loginButton.centerX(to: self.view)
        
        registerLabel.bottomToSuperview(offset: -35)
        registerLabel.leadingToSuperview(offset: 100)
        
        registerButton.leadingToTrailing(of: registerLabel, offset: 5)
        registerButton.centerY(to: registerLabel)
    }
    
    private func setupAction() {
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(signUpNowButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func signUpNowButtonTapped() {
        router.placeOnRegisterViewController()
    }
    
    @objc func forgotPasswordButtonTapped() {
        router.pushForgotPasswordViewController()
    }
    
    @objc func loginButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    @objc func googleButtonTapped() {
        viewModel.signInWithGoogle(presenting: self)
    }
}

//#Preview {
//    let router = LoginRouter()
//    let viewModel = LoginViewModel(router: router)
//    return LoginView(viewModel: viewModel, router: router)
//}
