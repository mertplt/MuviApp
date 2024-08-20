//
//  TitleTableViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import UIKit
import SDWebImage
import TinyConstraints

class SearchTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    let viewModel = SearchViewModel()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.surfaceDark
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.surfaceLight
        label.font = FontManager.bodyAndForms()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.mediumEmphasis
        label.font = FontManager.bodyAndForms()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ratingView = MaRatingView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = ColorManager.surfaceDark
        contentView.addSubview(containerView)
        containerView.edgesToSuperview(insets: TinyEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))
        
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(ratingView)
        
        posterImageView.leadingToSuperview(offset: 10)
        posterImageView.topToSuperview(offset: 10)
        posterImageView.bottomToSuperview(offset: 10)
        posterImageView.width(178)
        
        titleLabel.top(to: posterImageView)
        titleLabel.leadingToTrailing(of: posterImageView, offset: 10)
        titleLabel.trailingToSuperview(offset: 10)
        
        dateLabel.topToBottom(of: titleLabel, offset: 8)
        dateLabel.leading(to: titleLabel)
        
        ratingView.topToBottom(of: dateLabel, offset: 15)
        ratingView.leading(to: dateLabel)
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        dateLabel.text = getFormattedReleaseDate(movie: movie, tvShow: nil)
        ratingView.configure(rating: movie.voteAverage ?? 0, voteCount: movie.voteCount ?? 0, isVoteCountHidden: true)
        
        if let backdropPath = movie.backdropPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)") {
            posterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            posterImageView.image = UIImage(named: "placeholder")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        dateLabel.text = nil
    }
}
