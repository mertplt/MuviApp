//
//  PortraitCollectionViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import UIKit
import TinyConstraints

final class PortraitCollectionViewCell: UICollectionViewCell {
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
//    private let cellTitleLbl: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .left
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
//        contentView.addSubview(cellTitleLbl)
        cellImageView.clipsToBounds = true
        cellImageView.topToSuperview()
        cellImageView.edgesToSuperview()
        
//        cellTitleLbl.topToBottom(of: cellImageView)
//        cellTitleLbl.edgesToSuperview(excluding: .top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: ListItem) {
        cellImageView.image = UIImage(named: item.image)
//        cellTitleLbl.text = item.title
    }
}
