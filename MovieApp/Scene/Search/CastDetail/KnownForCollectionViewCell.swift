//
//  KnownForCollectionViewCell.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import UIKit
import SDWebImage

class KnownForCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = ColorManager.surfaceLight.cgColor
        
        return imageView
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
        
        imageView.edgesToSuperview()
    }
    
    func configure(with movieId: Int) {
        let movieService = MovieService()
        movieService.fetchMovieDetails(for: movieId) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    if let posterPath = movie.posterPath {
                        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                        self?.imageView.sd_setImage(with: url, completed: nil)
                    }
                }
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }
}
