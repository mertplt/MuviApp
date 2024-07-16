//
//  CustomHeaderReusableView.swift
//  MovieApp
//
//  Created by Mert Polat on 15.07.24.
//

import UIKit
import TinyConstraints
import SDWebImage

final class CustomHeaderReusableView: UICollectionReusableView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, ColorManager.surfaceDark.withAlphaComponent(1).cgColor]
        layer.locations = [0.5, 1.0]
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.edgesToSuperview()
        imageView.heightAnchor.constraint(equalToConstant: 259).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        imageView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = imageView.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with imageURL: String?) {
        if let imageURL = imageURL, let url = URL(string: imageURL) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
