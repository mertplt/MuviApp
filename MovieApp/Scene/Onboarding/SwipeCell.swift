//
//  SwipeCell.swift
//  MovieApp
//
//  Created by mert polat on 8.02.2024.
//

import UIKit

class SwipeCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SwipeCell"
    
    let peopleImageView = UIImageView()
    let headlineLabel = UILabel()
    let subheadlineLabel = UILabel()
    let descriptionStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(image: String, headline: String, subheadline: String) {
        peopleImageView.image = UIImage(named: image)
        headlineLabel.text = headline
        subheadlineLabel.text = subheadline
    }
    
    func configure() {
        peopleImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(peopleImageView)
        
        headlineLabel.textAlignment = .center
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headlineLabel.textColor = .label
        headlineLabel.numberOfLines = 0
        
        subheadlineLabel.textAlignment = .center
        subheadlineLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subheadlineLabel.textColor = .secondaryLabel
        subheadlineLabel.numberOfLines = 0
        
        descriptionStackView.addArrangedSubview(headlineLabel)
        descriptionStackView.addArrangedSubview(subheadlineLabel)
        
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 10
        descriptionStackView.alignment = .center
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(descriptionStackView)
    }
    
}
