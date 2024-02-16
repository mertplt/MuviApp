//
//  FirstOnboardingViewController.swift
//  MovieApp
//
//  Created by mert polat on 11.02.2024.
//

import UIKit
import TinyConstraints

final class FirstOnboardingViewController: UIViewController {

    let signInButton: MaButton = {
       let button = MaButton()
        button.style = .largeButtonDark
        button.buttonTitle = "Sign In"
        return button
    }()

    let watchMovieButton: MaButton = {
       let button = MaButton()
        button.style = .largeButtonYellow
        button.buttonTitle = "Watch Movie"

        return button
    }()
    
    let headlineLabel: UILabel = {
       let label = UILabel()
        label.font = FontManager.headline1()
        label.textColor = .surfaceLight
        label.text = "Welcome to Muvi"
        return label
    }()
    
    let subHeadlineLabel: UILabel = {
       let label = UILabel()
        label.font = FontManager.subtitleAndMenu()
        label.textColor = .surfaceLight
        label.text = "Free movie streaming all your needs \n everytime and everywhere."
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .welcome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        watchMovieButton.addTarget(self, action: #selector(watchMovieButtonTapped(_:)), for: .touchUpInside)
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)

        view.backgroundColor = ColorManager.surfaceDark
        view.addSubview(imageView)
        view.addSubview(subHeadlineLabel)
        view.addSubview(headlineLabel)
        view.addSubview(watchMovieButton)
        view.addSubview(signInButton)
        
        updateConstraints()
    }

    
    private func updateConstraints() {
        imageView.leadingToSuperview(offset: 68)
        imageView.topToSuperview(offset: 180)
        
        headlineLabel.leadingToSuperview(offset: 105)
        headlineLabel.topToSuperview(offset: 468)
        
        subHeadlineLabel.leadingToSuperview(offset: 51)
        subHeadlineLabel.topToBottom(of: headlineLabel,offset: 8)
        
        signInButton.leadingToSuperview(offset: 20)
        signInButton.bottomToSuperview(offset: -50)
        
        watchMovieButton.leading(to: signInButton)
        watchMovieButton.bottomToTop(of: signInButton,offset: 0)
    }

    @objc func watchMovieButtonTapped(_ button: UIButton) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let onboardingVC = OnboardingViewController(collectionViewLayout: layout)
        onboardingVC.modalPresentationStyle = .fullScreen
        present(onboardingVC,animated: true)
    }
    
    @objc func signInButtonTapped(_ button: UIButton) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let LoginV = LoginView()
        LoginV.modalPresentationStyle = .fullScreen
        present(LoginV,animated: true)
    }

}
