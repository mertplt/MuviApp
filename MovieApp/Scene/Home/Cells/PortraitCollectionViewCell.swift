//
//  PortraitCollectionViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import UIKit
import TinyConstraints
import SDWebImage

final class PortraitCollectionViewCell: UICollectionViewCell {
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        cellImageView.clipsToBounds = true
        
        cellImageView.topToSuperview()
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
