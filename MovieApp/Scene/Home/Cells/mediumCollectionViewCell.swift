//
//  mediumCollectionViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 6.07.2024.
//

import UIKit
import SDWebImage

class MediumCollectionViewCell: UICollectionViewCell {
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        cellImageView.clipsToBounds = true
        cellImageView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: ListItem) {
        if let url = URL(string: item.backdrop ?? item.image) {
            cellImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cellImageView.image = UIImage(named: "placeholder")
        }
    }
}
