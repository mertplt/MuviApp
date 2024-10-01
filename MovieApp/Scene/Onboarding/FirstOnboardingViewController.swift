//
//  FirstOnboardingViewController.swift
//  MovieApp
//
//  Created by mert polat on 11.02.2024.
//

import UIKit
import TinyConstraints

final class FirstOnboardingViewController: UIViewController {

    private var router: FirstOnboardingRouter

    init(router: FirstOnboardingRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let signInButton: MaButton = {
        let button = MaButton()
        button.style = .largeButtonDark
        button.buttonTitle = "Sign In"
        return button
    }()
    
    private let watchMovieButton: MaButton = {
        let button = MaButton()
        button.style = .largeButtonYellow
        button.buttonTitle = "Watch Movie"
        return button
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.headline1()
        label.textColor = .surfaceLight
        label.text = "Welcome to Muvi"
        return label
    }()
    
    private let subHeadlineLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.subtitleAndMenu()
        label.textColor = .surfaceLight
        label.text = """
        Free movie streaming all your needs
        everytime and everywhere.
        """
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .welcome
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupActions()
    }

    private func configureUI() {
        view.backgroundColor = ColorManager.surfaceDark
        [imageView, subHeadlineLabel, headlineLabel, watchMovieButton, signInButton].forEach {
            view.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.leadingToSuperview(offset: 68)
        imageView.topToSuperview(offset: 180)
        
        headlineLabel.leadingToSuperview(offset: 105)
        headlineLabel.topToSuperview(offset: 468)
        
        subHeadlineLabel.leadingToSuperview(offset: 51)
        subHeadlineLabel.topToBottom(of: headlineLabel, offset: 8)
        
        signInButton.centerX(to: self.view)
        signInButton.bottomToSuperview(offset: -50)
        
        watchMovieButton.leading(to: signInButton)
        watchMovieButton.bottomToTop(of: signInButton, offset: 0)
    }

    private func setupActions() {
        watchMovieButton.addTarget(self, action: #selector(watchMovieButtonTapped(_:)), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
    }

    @objc private func watchMovieButtonTapped(_ button: UIButton) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let onboardingVC = OnboardingViewController(collectionViewLayout: layout)
        onboardingVC.modalPresentationStyle = .fullScreen
        present(onboardingVC, animated: true)
    }

    @objc private func signInButtonTapped(_ button: UIButton) {
        router.placeOnLoginViewController()
    }
}
