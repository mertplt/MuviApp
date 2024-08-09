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
    
    init(viewModel: RegisterViewModel, router: RegisterRouter) {
        self.registerViewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainLabel: UILabel = {
       let label = UILabel()
        label.text = "Create Account"
        label.font = FontManager.headline1()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    let expLabel: UILabel = {
        let label = UILabel()
         label.text = "Enter information below or login with social\naccount to get started"
         label.textAlignment = .left
         label.numberOfLines = 2
         label.font = FontManager.paragraphAndButton()
         label.textColor = ColorManager.surfaceLight
         return label
    }()
    
    let emailTextField : MaTextField = {
      let textField = MaTextField()
        textField.style = .email
        return textField
    }()
    
    let emailLineView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    let passwordTextField : MaTextField = {
      let textField = MaTextField()
        textField.style = .password
        return textField
    }()
    
    let passwordLineView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    let confirmPasswordTextField : MaTextField = {
      let textField = MaTextField()
        textField.style = .password
        textField.placeholderText = "Confirm Password"
        return textField
    }()
    
    let confirmPasswordLineView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12)
        view.height(1.5)
        view.alpha = 0.12
        view.width(335)
        return view
    }()
    
    let backButton : UIButton = {
        let button = UIButton()
        button.setImage(.arrowLeft, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let orContinueWithLabel : UILabel = {
        let label = UILabel()
        label.text = "or continue with"
        label.textColor = ColorManager.highEmphasis
        label.backgroundColor = ColorManager.surfaceDark
        label.font = FontManager.paragraphAndButton()
        return label
    }()
    
    let googleButton : UIButton = {
       let button = UIButton()
        button.setImage(.google, for: .normal)
        button.backgroundColor = UIColor(red: 0.176, green: 0.186, blue: 0.2, alpha: 1)
        button.size(CGSize(width: 44, height: 44))
        return button
    }()
    
    let faceBookButton : UIButton = {
       let button = UIButton()
        button.setImage(.facebook1, for: .normal)
        button.backgroundColor = UIColor(red: 0.176, green: 0.186, blue: 0.2, alpha: 1)
        button.size(CGSize(width: 44, height: 44))
        return button
    }()
    
    let registerButton : MaButton = {
        let button = MaButton()
        button.style = .largeButtonYellow
        button.buttonTitle = "Register"
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        setupGoogleButton()
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func configureUI(){
        view.backgroundColor = ColorManager.surfaceDark
        
        view.addSubview(mainLabel)
        view.addSubview(expLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailLineView)
        view.addSubview(passwordLineView)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordLineView)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(backButton)
        view.addSubview(orContinueWithLabel)
        view.addSubview(googleButton)
        view.addSubview(faceBookButton)
        view.addSubview(registerButton)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        mainLabel.topToSuperview(offset: 127)
        mainLabel.leftToSuperview(offset: 20)
        
        expLabel.topToBottom(of: mainLabel, offset: 9)
        expLabel.left(to: mainLabel)
        
        emailTextField.leadingToSuperview(offset: 20)
        emailTextField.topToBottom(of: expLabel, offset: 24)
        
        emailLineView.topToBottom(of: emailTextField, offset: 0)
        emailLineView.leading(to: emailTextField)
        emailLineView.trailing(to: emailTextField)
        
        passwordTextField.topToBottom(of: emailLineView, offset: 15)
        passwordTextField.leading(to: emailTextField)
        passwordTextField.trailing(to: emailTextField)
        
        passwordLineView.topToBottom(of: passwordTextField, offset: 0)
        passwordLineView.leading(to: passwordTextField)
        passwordLineView.trailing(to: passwordTextField)
        
        confirmPasswordTextField.topToBottom(of: passwordLineView, offset: 15)
        confirmPasswordTextField.leading(to: passwordTextField)
        confirmPasswordTextField.trailing(to: passwordTextField)
        
        confirmPasswordLineView.topToBottom(of: confirmPasswordTextField, offset: 0)
        confirmPasswordLineView.leading(to: confirmPasswordTextField)
        confirmPasswordLineView.trailing(to: confirmPasswordTextField)
        
        orContinueWithLabel.topToBottom(of: confirmPasswordTextField, offset: 40)
        orContinueWithLabel.leadingToSuperview(offset: 20)
        
        googleButton.topToBottom(of: orContinueWithLabel, offset: 15)
        googleButton.leading(to: orContinueWithLabel)
        
        faceBookButton.top(to: googleButton)
        faceBookButton.leadingToTrailing(of: googleButton, offset: 16)
        
        registerButton.bottomToSuperview(offset: -70)
        registerButton.centerX(to: self.view)
    }
    
    @objc func backButtonTapped() {
        router.placeOnLoginViewController()
    }
    
    @objc func registerButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        registerViewModel.register(email: email, password: password, confirmPassword: confirmPassword)
        
        let mainTabBarVC = MainTabBarViewController()
        mainTabBarVC.modalPresentationStyle = .fullScreen
        present(mainTabBarVC, animated: true)
    }
}

#Preview {
    RegisterView(viewModel: RegisterViewModel(router: RegisterRouter()), router: RegisterRouter())
}
