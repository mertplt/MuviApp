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
    
    let backButton : UIButton = {
        let button = UIButton()
        button.setImage(.arrowLeft, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let mainLabel: UILabel = {
       let label = UILabel()
        label.text = "Forgot Password?"
        label.font = FontManager.headline1()
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    let expLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm your email and we’llsend\nthe instructions."
        label.textAlignment = .center
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
    

    let resetPasswordButton : MaButton = {
        let button = MaButton()
        button.style = .largeButtonYellow
        button.buttonTitle = "Reset Password"
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }

    func configureUI(){
        view.backgroundColor = ColorManager.surfaceDark
        view.addSubview(mainLabel)
        view.addSubview(expLabel)
        view.addSubview(emailTextField)
        view.addSubview(backButton)
        view.addSubview(resetPasswordButton)
        view.addSubview(emailLineView)
        
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        mainLabel.topToSuperview(offset: 127)
        mainLabel.centerX(to: self.view)
        
        expLabel.topToBottom(of: mainLabel,offset: 9)
        expLabel.leading(to: mainLabel)
        
        emailTextField.leadingToSuperview(offset: 20)
        emailTextField.topToBottom(of: expLabel,offset: 24)
        
        emailLineView.topToBottom(of: emailTextField,offset: 0)
        emailLineView.leading(to: emailTextField)
        emailLineView.trailing(to: emailTextField)
        
        resetPasswordButton.topToBottom(of:  emailTextField,offset: 40)
        resetPasswordButton.centerX(to: self.view)

        
        
    }
    
    @objc func backButtonTapped() {
        router.placeOnLoginViewController()
    }
}

#Preview {
    ForgotPasswordView(router: ForgotPasswordRouter())
}
