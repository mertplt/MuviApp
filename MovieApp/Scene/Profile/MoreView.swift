//
//  ProfileView.swift
//  MovieApp
//
//  Created by Mert Polat on 30.06.2024.
//

import UIKit
import TinyConstraints
import FirebaseAuth
import SDWebImage

class MoreView: UIViewController {
    
    private let viewModel = MoreViewModel()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Auth.auth().currentUser?.email
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(ColorManager.primary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let menuItems: [(icon: String, title: String)] = [
        ("inbox", "Inbox"),
        ("user", "Account Settings"),
        ("globe", "Language"),
        ("info", "Help, FAQ")
    ]
    
    private lazy var menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        
        for (icon, title) in menuItems {
            let itemView = createMenuItemView(icon: icon, title: title)
            stackView.addArrangedSubview(itemView)
        }
        
        return stackView
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms & Condition", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy & Policy", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let logoutButton: MaButton = {
        let button = MaButton()
        button.style = .largeButtonDark
        button.buttonTitle = "Log Out"
        button.setTitleColor(UIColor(red: 1, green: 0.51, blue: 0.51, alpha: 1)
                             , for: .normal)
        button.layer.borderColor = ColorManager.disabled.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(logOutClicked), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserProfile()
    }
    
    private func fetchUserProfile() {
        viewModel.fetchUserProfile { [weak self] result in
            switch result {
            case .success():
                self?.updateUI()
            case .failure(let error):
                print("Failed to fetch user profile: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI() {
         if let userProfile = viewModel.userProfile {
             nameLabel.text = userProfile.name
             emailLabel.text = Auth.auth().currentUser?.email
             if let profileImageURL = userProfile.profileImageURL, let url = URL(string: profileImageURL) {
                 profileImageView.sd_setImage(
                     with: url,
                     placeholderImage: UIImage(named: "default_profile_image"),
                     options: [.progressiveLoad, .refreshCached],
                     completed: { [weak self] image, error, cacheType, imageURL in
                         if let error = error {
                             print("Failed to load profile image: \(error.localizedDescription)")
                         } else {
                             print("Profile image loaded successfully")
                         }
                     }
                 )
             } else {
                 profileImageView.image = UIImage(named: "default_profile_image")
             }
         }
     }
    
    private func setupUI() {
        view.backgroundColor = ColorManager.surfaceDark
        
        [profileImageView, nameLabel, emailLabel, editProfileButton, menuStackView, termsButton, privacyButton, logoutButton].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        profileImageView.topToSuperview(offset: 20, usingSafeArea: true)
        profileImageView.centerX(to: view)
        profileImageView.width(100)
        profileImageView.height(100)
        
        nameLabel.topToBottom(of: profileImageView, offset: 10)
        nameLabel.centerX(to: view)
        
        emailLabel.topToBottom(of: nameLabel, offset: 5)
        emailLabel.centerX(to: view)
        
        editProfileButton.topToBottom(of: emailLabel, offset: 10)
        editProfileButton.centerX(to: view)
        
        menuStackView.topToBottom(of: editProfileButton, offset: 30)
        menuStackView.leftToSuperview(offset: 20)
        menuStackView.rightToSuperview(offset: -20)
        
        termsButton.bottomToTop(of: privacyButton, offset: -10)
        termsButton.leading(to: menuStackView)
        
        privacyButton.bottomToTop(of: logoutButton, offset: -20)
        privacyButton.leading(to: menuStackView)
        
        logoutButton.bottomToSuperview(offset: -40, usingSafeArea: true)
        logoutButton.leftToSuperview(offset: 20)
        logoutButton.rightToSuperview(offset: -20)
        logoutButton.height(50)
    }
    
    private func createMenuItemView(icon: String, title: String) -> UIView {
        let containerView = UIView()
        
        let iconImageView = UIImageView(image: UIImage(named: icon))
        iconImageView.tintColor = .white
        containerView.addSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        containerView.addSubview(titleLabel)
        
        iconImageView.leftToSuperview()
        iconImageView.centerY(to: containerView)
        iconImageView.size(CGSize(width: 24, height: 24))
        
        titleLabel.leftToRight(of: iconImageView, offset: 16)
        titleLabel.centerY(to: containerView)
        
        containerView.height(30)
        
        return containerView
    }
    
    @objc func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigateToFirstOnboarding()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @objc func editButtonTapped(_ sender: Any){
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }

    private func navigateToFirstOnboarding() {
        let firstOnboardingVC = FirstOnboardingViewController(router: FirstOnboardingRouter())
        let navigationController = UINavigationController(rootViewController: firstOnboardingVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }

}

