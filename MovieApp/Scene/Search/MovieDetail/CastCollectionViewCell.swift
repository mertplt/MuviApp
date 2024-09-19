//
//  CastCollectionViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import UIKit
import SDWebImage

class CastCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8

        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.paragraphAndButton()
        label.textColor = ColorManager.surfaceLight
        label.textAlignment = .center
        return label
    }()
    
    private lazy var characterLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.paragraphAndButton()
        label.textColor = ColorManager.highEmphasis
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(characterLabel)

        imageView.edgesToSuperview(excluding: .bottom)
        imageView.height(150)

        nameLabel.topToBottom(of: imageView, offset: 5)
        nameLabel.leadingToSuperview()
        nameLabel.trailingToSuperview()
        nameLabel.numberOfLines = 3

        characterLabel.topToBottom(of: nameLabel, offset: 5)
        characterLabel.leadingToSuperview()
        characterLabel.trailingToSuperview()
        characterLabel.numberOfLines = 3
    }

    func configure(with castMember: Cast) {
        nameLabel.text = castMember.name
        characterLabel.text = castMember.character
        if let profilePath = castMember.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
            imageView.sd_setImage(with: url, completed: nil)
        } else {
            imageView.image = UIImage(named: "default-profile")
        }
    }

    func configure(with castMember: TVCast) {
        nameLabel.text = castMember.name
        characterLabel.text = castMember.character
        if let profilePath = castMember.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
            imageView.sd_setImage(with: url, completed: nil)
        } else {
            imageView.image = UIImage(named: "default-profile")
        }
    }
}
