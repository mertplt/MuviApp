//
//  CollectionViewHeaderReusableView.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import UIKit
import TinyConstraints

final class CollectionViewHeaderReusableView: UICollectionReusableView {
    
    private let cellTitleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cellTitleLbl)
        
        cellTitleLbl.edgesToSuperview(excluding: .left)
        cellTitleLbl.leftToSuperview(offset: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ title: String) {
        cellTitleLbl.text = title
    }
}
