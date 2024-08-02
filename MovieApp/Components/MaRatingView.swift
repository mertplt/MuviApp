//
//  MaRatingView.swift
//  MovieApp
//
//  Created by Mert Polat on 02.08.24.
//

import UIKit

class MaRatingView: UIView {
    private let ratingLabel = UILabel()
    private let starImageView = UIImageView()
    private let voteCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(starImageView)
        addSubview(ratingLabel)
        addSubview(voteCountLabel)
        
        starImageView.image = .star
        
        ratingLabel.font = FontManager.bodyAndForms()
        ratingLabel.textColor = ColorManager.surfaceLight
        
        voteCountLabel.font = FontManager.paragraphAndButton()
        voteCountLabel.textColor = ColorManager.highEmphasis
        
        starImageView.leadingToSuperview()
        starImageView.centerY(to: self)
        starImageView.width(16)
        starImageView.height(16)
        
        ratingLabel.leadingToTrailing(of: starImageView, offset: 4)
        ratingLabel.centerY(to: self)
        ratingLabel.trailingToSuperview()
        
        voteCountLabel.leading(to: starImageView,offset: 3)
        voteCountLabel.topToBottom(of: ratingLabel,offset: 5)
    }
    
    func configure(with rating: Double,voteCount:Int) {
        ratingLabel.text = String(format: "%.1f", rating)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSize = 3
        voteCountLabel.text = numberFormatter.string(from: NSNumber(value: voteCount)) ?? String(voteCount)    }
    
}
