//
//  MaRatingView.swift
//  MovieApp
//
//  Created by Mert Polat on 02.08.24.
//

import UIKit
import TinyConstraints

class MaRatingView: UIView {
    private let ratingLabel = UILabel()
    private let starImageView = UIImageView()
    private let voteCountLabel = UILabel()
    
    var rating: Double = 0.0 {
        didSet {
            updateRatingLabel()
        }
    }
    
    var voteCount: Int = 0 {
        didSet {
            updateVoteCountLabel()
        }
    }
    
    var isVoteCountHidden: Bool = false {
        didSet {
            voteCountLabel.isHidden = isVoteCountHidden
        }
    }
    
    var ratingFont: UIFont = FontManager.bodyAndForms() {
        didSet {
            ratingLabel.font = ratingFont
        }
    }
    
    var voteCountFont: UIFont = FontManager.paragraphAndButton() {
        didSet {
            voteCountLabel.font = voteCountFont
        }
    }
    
    var ratingColor: UIColor = ColorManager.surfaceLight {
        didSet {
            ratingLabel.textColor = ratingColor
        }
    }
    
    var voteCountColor: UIColor = ColorManager.highEmphasis {
        didSet {
            voteCountLabel.textColor = voteCountColor
        }
    }
    
    var starImage: UIImage = .star {
        didSet {
            starImageView.image = starImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(starImageView)
        addSubview(ratingLabel)
        addSubview(voteCountLabel)
        
        starImageView.image = starImage
        
        ratingLabel.font = ratingFont
        ratingLabel.textColor = ratingColor
        
        voteCountLabel.font = voteCountFont
        voteCountLabel.textColor = voteCountColor
        
        setupConstraints()
        updateRatingLabel()
        updateVoteCountLabel()
    }
    
    private func setupConstraints() {
        starImageView.leadingToSuperview()
        starImageView.centerY(to: self)
        starImageView.width(16)
        starImageView.height(16)
        
        ratingLabel.leadingToTrailing(of: starImageView, offset: 4)
        ratingLabel.centerY(to: self)
        
        voteCountLabel.leading(to: starImageView, offset: 3)
        voteCountLabel.topToBottom(of: ratingLabel, offset: 5)
        voteCountLabel.trailingToSuperview()
    }
    
    private func updateRatingLabel() {
        ratingLabel.text = String(format: "%.1f", rating)
    }
    
    private func updateVoteCountLabel() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSize = 3
        voteCountLabel.text = numberFormatter.string(from: NSNumber(value: voteCount)) ?? String(voteCount)
    }
    
    func configure(rating: Double, voteCount: Int, isVoteCountHidden: Bool = false) {
        self.rating = rating
        self.voteCount = voteCount
        self.isVoteCountHidden = isVoteCountHidden
    }
}
