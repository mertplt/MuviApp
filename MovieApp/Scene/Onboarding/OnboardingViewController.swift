//
//  OnboardingViewController.swift
//  MovieApp
//
//  Created by mert polat on 7.02.2024.
//

import UIKit
import TinyConstraints

final class OnboardingViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let swipeItems = [
        SwipeItem(image: "", headline: "Enjoy your favourite movie\neverywhere", subheadline: "Browse through our collections and\ndiscover hundreds of movies and series that\nyou’ll love!", screen: 1),
        SwipeItem(image: "App-Preview1", headline: "Create your profile", subheadline: "Create your profile to start\nwatching your favourite movies and\nseries.", screen: 2),
        SwipeItem(image: "App-Preview2", headline: "Welcome to Muvi", subheadline: "Look back and reflect on your memories \n and growth over time.", screen: 3)
    ]
    
    let pageControl = UIPageControl()
    let bottomStackView = UIStackView()

    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.surfaceDark
        return view
    }()
    
    private let getStartedButton: MaButton = {
        let button = MaButton()
        button.buttonTitle = "Get Started"
        button.layer.borderColor = ColorManager.disabled.cgColor
        button.layer.borderWidth = 2
        button.style = .bigButton
        button.backgroundColor = ColorManager.surfaceDark
        button.setTitleColor(ColorManager.surfaceLight, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swipeItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwipeCell.reuseIdentifier, for: indexPath) as! SwipeCell
        let swipeItem = swipeItems[indexPath.item]
        cell.update(image: swipeItem.image ?? "", headline: swipeItem.headline ?? "", subheadline: swipeItem.subheadline ?? "")
        
        configureCell(cell, for: swipeItem.screen)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let currentPage = Int(x / view.frame.width)
        pageControl.currentPage = currentPage
    }

    private func configureViewController() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = ColorManager.surfaceDark
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SwipeCell.self, forCellWithReuseIdentifier: SwipeCell.reuseIdentifier)
        
        configureBottomStackView()
        setupConstraints()
        
        getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped(_:)), for: .touchUpInside)
    }

    private func configureBottomStackView() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = swipeItems.count
        pageControl.currentPageIndicatorTintColor = ColorManager.primary
        pageControl.pageIndicatorTintColor = ColorManager.mediumEmphasis
        
        bottomStackView.addArrangedSubview(pageControl)
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bottomStackView.heightAnchor.constraint(equalToConstant: 0),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureCell(_ cell: SwipeCell, for screen: Int) {
        switch screen {
        case 1:
            setupFirstScreen(cell: cell)
        case 2:
            setupSecondScreen(cell: cell)
        case 3:
            setupThirdScreen(cell: cell)
        default:
            cell.backgroundColor = ColorManager.surfaceDark
        }
    }

    private func setupFirstScreen(cell: SwipeCell) {
        cell.backgroundView = UIImageView(image: .fullScreen)
        cell.peopleImageView.isHidden = true
        configureHeadlineLabel(cell, offset: 346)
        configureSubheadlineLabel(cell, below: cell.headlineLabel, offset: 16)
    }

    private func setupSecondScreen(cell: SwipeCell) {
        cell.backgroundColor = ColorManager.surfaceDark
        cell.peopleImageView.contentMode = .scaleAspectFit
        configureHeadlineLabel(cell, offset: 150)
        configureSubheadlineLabel(cell, below: cell.headlineLabel, offset: 15)
        cell.peopleImageView.leadingToSuperview(offset: 28)
        cell.peopleImageView.bottomToSuperview(offset: 0)
    }

    private func setupThirdScreen(cell: SwipeCell) {
        cell.backgroundColor = .orange
        cell.peopleImageView.contentMode = .scaleAspectFit
        cell.addSubview(footerView)
        cell.peopleImageView.bottomToSuperview(offset: -55)
        cell.peopleImageView.leadingToSuperview(offset: 28)

        footerView.addSubview(cell.headlineLabel)
        footerView.addSubview(cell.subheadlineLabel)
        footerView.addSubview(getStartedButton)

        setupFooterViewConstraints(cell)
    }

    private func setupFooterViewConstraints(_ cell: SwipeCell) {
        footerView.bottomToSuperview(offset: 0)
        footerView.leadingToSuperview(offset: 0)
        footerView.trailingToSuperview(offset: 0)
        footerView.height(280)
        footerView.layer.cornerRadius = 20

        cell.subheadlineLabel.bottomToTop(of: getStartedButton, offset: -25)
        cell.subheadlineLabel.centerXToSuperview()
        cell.subheadlineLabel.textColor = ColorManager.surfaceLight
        cell.subheadlineLabel.textAlignment = .center

        cell.headlineLabel.bottomToTop(of: cell.subheadlineLabel, offset: -12)
        cell.headlineLabel.centerXToSuperview()
        cell.headlineLabel.textColor = ColorManager.surfaceLight

        getStartedButton.bottomToSuperview(offset: -100)
        getStartedButton.centerXToSuperview()
    }

    private func configureHeadlineLabel(_ cell: SwipeCell, offset: CGFloat) {
        cell.headlineLabel.textColor = ColorManager.surfaceLight
        cell.headlineLabel.font = FontManager.headline1()
        cell.headlineLabel.textAlignment = .left
        cell.headlineLabel.leadingToSuperview(offset: 20)
        cell.headlineLabel.topToSuperview(offset: offset)
    }

    private func configureSubheadlineLabel(_ cell: SwipeCell, below view: UIView, offset: CGFloat) {
        cell.subheadlineLabel.leadingToSuperview(offset: 20)
        cell.subheadlineLabel.topToBottom(of: view, offset: offset)
        cell.subheadlineLabel.numberOfLines = 0
        cell.subheadlineLabel.textAlignment = .left
        cell.subheadlineLabel.font = FontManager.subtitleAndMenu()
        cell.subheadlineLabel.textColor = ColorManager.surfaceLight
    }

    @objc private func getStartedButtonTapped(_ button: UIButton) {
        let loginViewModel = LoginViewModel(router: LoginRouter())
        let loginVC = LoginView(viewModel: loginViewModel, router: LoginRouter())
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
}
