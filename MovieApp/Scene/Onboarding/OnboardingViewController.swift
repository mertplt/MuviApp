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
        SwipeItem(image: "App-Preview1", headline: "Welcome to Muvi", subheadline: "Look back and reflect on your memories \n and growth over time.", screen: 2),
        SwipeItem(image: "App-Preview2", headline: "Welcome to Muvi", subheadline: "Look back and reflect on your memories \n and growth over time.", screen: 3)
    ]
    
    let pageControl = UIPageControl()
    let bottomStackView = UIStackView()
    
    let footerView : UIView = {
       let UIView = UIView()
        UIView.backgroundColor = ColorManager.surfaceDark
        return UIView
    }()
    
    let getStartedButton : MaButton = {
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
        
        let paragraphStyle = NSMutableParagraphStyle()
        switch swipeItem.screen {
            case 1:
        cell.backgroundView = UIImageView(image: .fullScreen)
        cell.peopleImageView.isHidden = true
        cell.headlineLabel.textColor = ColorManager.surfaceLight
        cell.headlineLabel.font = FontManager.headline1()
        cell.headlineLabel.textAlignment = .left
            cell.headlineLabel.numberOfLines = 0
            cell.headlineLabel.leadingToSuperview(offset: 20)
            cell.headlineLabel.topToSuperview(offset: 346)
            cell.subheadlineLabel.leadingToSuperview(offset: 20)
            cell.subheadlineLabel.topToBottom(of: cell.headlineLabel,offset: 16)
            cell.subheadlineLabel.numberOfLines = 0
            cell.subheadlineLabel.textAlignment = .left
            cell.subheadlineLabel.font = FontManager.subtitleAndMenu()
            cell.subheadlineLabel.textColor = ColorManager.surfaceLight

        print(swipeItem.screen)

            case 2:
            cell.backgroundColor = ColorManager.surfaceDark
            cell.peopleImageView.contentMode = .scaleAspectFit
            cell.headlineLabel.textColor = ColorManager.surfaceLight
            cell.subheadlineLabel.textColor = ColorManager.surfaceLight
            cell.headlineLabel.topToSuperview(offset: 150)
            cell.headlineLabel.leadingToSuperview(offset: 20)
            cell.headlineLabel.font = FontManager.headline1()
            cell.subheadlineLabel.topToBottom(of: cell.headlineLabel,offset: 15)
            cell.subheadlineLabel.leadingToSuperview(offset: 20)
            cell.subheadlineLabel.font = FontManager.subtitleAndMenu()
            cell.peopleImageView.leadingToSuperview(offset: 28)
            cell.peopleImageView.bottomToSuperview(offset: 0)
            
            case 3:
            cell.backgroundColor = .orange
            cell.peopleImageView.contentMode = .scaleAspectFit
            cell.addSubview(footerView)
            cell.peopleImageView.bottomToSuperview(offset: -55)
            cell.peopleImageView.leadingToSuperview(offset: 28)
            footerView.addSubview(cell.headlineLabel)
            footerView.addSubview(cell.subheadlineLabel)
            footerView.addSubview(getStartedButton)
            footerView.bottomToSuperview(offset: 0)
            footerView.leadingToSuperview(offset: 0)
            footerView.trailingToSuperview(offset: 0)
            footerView.height(280)
            footerView.layer.cornerRadius = 20
            cell.subheadlineLabel.bottomToTop(of: getStartedButton,offset: -25)
            cell.subheadlineLabel.centerXToSuperview()
            cell.subheadlineLabel.textColor = ColorManager.surfaceLight
            cell.subheadlineLabel.textAlignment = .center
            cell.subheadlineLabel.font = FontManager.subtitleAndMenu()
            cell.headlineLabel.textColor = ColorManager.surfaceLight
            cell.headlineLabel.textAlignment = .center
            cell.headlineLabel.font = FontManager.headline1()
            cell.headlineLabel.bottomToTop(of: cell.subheadlineLabel,offset: -12)
            cell.headlineLabel.centerXToSuperview()
            getStartedButton.bottomToSuperview(offset: -100)
            getStartedButton.centerXToSuperview()
            default:
                cell.backgroundColor = ColorManager.surfaceDark
        }
        cell.headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.subheadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.peopleImageView.translatesAutoresizingMaskIntoConstraints = false
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

    func configureBottomStackView() {

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
    
    func configureViewController() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 200) 
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)

        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = ColorManager.surfaceDark
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SwipeCell.self, forCellWithReuseIdentifier: SwipeCell.reuseIdentifier)
        
        configureBottomStackView()
        
        NSLayoutConstraint.activate([
            bottomStackView.heightAnchor.constraint(equalToConstant: 100),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped(_:)), for: .touchUpInside)
    }

    @objc func getStartedButtonTapped(_ button: UIButton) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let LoginV = LoginView()
        LoginV.modalPresentationStyle = .fullScreen
        present(LoginV,animated: true)
    }
}
