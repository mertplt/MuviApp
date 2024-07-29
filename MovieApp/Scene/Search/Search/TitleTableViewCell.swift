//
//  TitleTableViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifer = "TitleTableViewCell"
    
    private let cellImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titlesLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.surfaceLight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellImageView)
        contentView.addSubview(titlesLabel)
        contentView.backgroundColor = ColorManager.surfaceDark
        applyConstraints()

    }
    
    private func applyConstraints(){
            cellImageView.width(168)
            cellImageView.height(89)
            cellImageView.leadingToSuperview(offset: 10)
            cellImageView.topToSuperview(offset: 0)
            
            titlesLabel.leadingToTrailing(of: cellImageView,offset: 10)
            titlesLabel.topToSuperview(offset: 0)
        
    }
    
    func setup(_ item: ListItem) {
        if let url = URL(string: item.image) {
            cellImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            titlesLabel.text = item.title
        } else {
            cellImageView.image = UIImage(named: "placeholder")
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
