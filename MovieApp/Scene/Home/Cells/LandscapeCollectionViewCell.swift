//
//  LandscapeCollectionViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import UIKit
import SDWebImage
import TinyConstraints

final class LandscapeCollectionViewCell: UICollectionViewCell {
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        
        cellImageView.edgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: ListItem) {
        if let url = URL(string: item.image) {
            cellImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cellImageView.image = UIImage(named: "placeholder")
        }
    }
}
