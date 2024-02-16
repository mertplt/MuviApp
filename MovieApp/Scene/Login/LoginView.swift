//
//  LoginView.swift
//  MovieApp
//
//  Created by mert polat on 16.02.2024.
//

import UIKit
import TinyConstraints

final class LoginView: UIViewController {
    
    let backgroundImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = .loginBackground
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel : UILabel = {
       let label = UILabel()
        label.font = FontManager.headline1()
        label.text = "Login"
        label.textColor = ColorManager.surfaceLight
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI(){
        view.backgroundColor = ColorManager.surfaceDark
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailLineView)
        view.addSubview(passwordTextField)
        view.addSubview(passwordLineView)
        
        backgroundImageView.topToSuperview(offset: 0)
        backgroundImageView.leadingToSuperview(offset: 0)
        backgroundImageView.trailingToSuperview(offset: 0)
        
        titleLabel.leadingToSuperview(offset: 20)
        titleLabel.topToBottom(of: backgroundImageView,offset: 33)
        
        emailTextField.leadingToSuperview(offset: 20)
        emailTextField.topToBottom(of: titleLabel,offset: 25)
        
        emailLineView.topToBottom(of: emailTextField,offset: 0)
        emailLineView.leading(to: emailTextField)
        emailLineView.trailing(to: emailTextField)
        
        passwordTextField.topToBottom(of: emailLineView,offset: 15)
        passwordTextField.leading(to: emailTextField)
        passwordTextField.trailing(to: emailTextField)
        
        passwordLineView.topToBottom(of: passwordTextField,offset: 0)
        passwordLineView.leading(to: passwordTextField)
        passwordLineView.trailing(to: passwordTextField)
        
        
        
    }

    
}



#Preview {
    LoginView()
}
