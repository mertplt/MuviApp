//
//  TitlePreviewViewController.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import UIKit
import WebKit
import TinyConstraints
import SDWebImage
import SafariServices

class TitlePreviewViewController: UIViewController {
    private var viewModel: TitlePreviewViewModel
    
    init(viewModel: TitlePreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = ColorManager.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, ColorManager.surfaceDark.withAlphaComponent(1).cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = ColorManager.surfaceLight.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.headline1()
        label.textColor = ColorManager.surfaceLight
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let ratingView = MaRatingView()
    private let runtimeLabel = UILabel()
    private let releaseDateLabel = UILabel()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.bodyAndForms()
        label.textColor = ColorManager.highEmphasis
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.subtitleAndMenu()
        label.textColor = ColorManager.surfaceLight
        label.numberOfLines = 8
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.bodyAndForms()
        label.textColor = ColorManager.highEmphasis
        label.numberOfLines = 0
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = FontManager.bodyAndForms()
        label.textColor = ColorManager.highEmphasis
        return label
    }()
    
    private lazy var trailerButton: MaButton = {
       let button = MaButton()
        button.style = .smallButtonYellow
        button.buttonTitle = "Watch Trailer"
        button.addTarget(self, action: #selector(watchTrailerTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addListButton: MaButton = {
       let button = MaButton()
        button.style = .smallButtonDark
        button.Icon = .plus
        button.buttonTitle = "My List"
        return button
    }()
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         updateGradientFrame()
     }
    
    private func setupUI() {
        view.backgroundColor = ColorManager.surfaceDark
        
        [backdropImageView, posterImageView, titleLabel, infoStackView, genresLabel, overviewLabel, castLabel, directorLabel, trailerButton, addListButton].forEach {
            view.addSubview($0)
        }
        
        view.addSubview(backButton)
        backButton.topToSuperview(view.safeAreaLayoutGuide.topAnchor, offset: 10)
        backButton.leadingToSuperview(offset: 10)
        backButton.width(44)
        backButton.height(44)
        
        backdropImageView.edgesToSuperview(excluding: .bottom)
        backdropImageView.height(250)
        backdropImageView.layer.addSublayer(gradientLayer)
        
        posterImageView.topToBottom(of: backdropImageView, offset: -50)
        posterImageView.leadingToSuperview(offset: 20)
        posterImageView.size(CGSize(width: 120, height: 180))
        
        titleLabel.topToBottom(of: backdropImageView, offset: 20)
        titleLabel.leadingToTrailing(of: posterImageView, offset: 20)
        titleLabel.trailingToSuperview(offset: 5)
        
        infoStackView.topToBottom(of: titleLabel, offset: 10)
        infoStackView.leadingToTrailing(of: posterImageView, offset: 20)
        
        [ratingView, runtimeLabel, releaseDateLabel].forEach { view in
            infoStackView.addArrangedSubview(view)
            if let label = view as? UILabel {
                label.textColor = ColorManager.highEmphasis
                label.font = FontManager.bodyAndForms()
            }
        }
        
        genresLabel.topToBottom(of: posterImageView, offset: 40)
        genresLabel.leading(to: posterImageView)
        genresLabel.trailingToSuperview(offset: 20)
        
        overviewLabel.topToBottom(of: genresLabel, offset: 20)
        overviewLabel.leadingToSuperview(offset: 20)
        overviewLabel.trailingToSuperview(offset: 20)
        
        castLabel.topToBottom(of: overviewLabel, offset: 20)
        castLabel.leadingToSuperview(offset: 20)
        castLabel.trailingToSuperview(offset: 20)
        
        directorLabel.topToBottom(of: castLabel, offset: 10)
        directorLabel.leadingToSuperview(offset: 20)
        directorLabel.trailingToSuperview(offset: 20)
        
        trailerButton.topToBottom(of: directorLabel, offset: 20)
        trailerButton.leadingToSuperview(offset: 20)
        
        addListButton.top(to: trailerButton)
        addListButton.trailingToSuperview(offset: 20)
    }

    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(error)
            }
        }
    }
    
    private func updateGradientFrame() {
        let height = backdropImageView.bounds.height
        let gradientHeight = height * 0.3
        gradientLayer.frame = CGRect(x: 0, y: height - gradientHeight, width: backdropImageView.bounds.width, height: gradientHeight)
    }
    
    private func updateUI() {
        if let movie = viewModel.movieDetails {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            ratingView.configure(rating: movie.voteAverage ?? 0.0, voteCount: movie.voteCount ?? 0)
            genresLabel.text = viewModel.getFormattedGenres()
            runtimeLabel.text = viewModel.getFormattedRuntime()
            releaseDateLabel.text = viewModel.getFormattedReleaseDate()
            infoStackView.trailingToSuperview(offset: 20)
            
            if let posterPath = movie.posterPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                posterImageView.sd_setImage(with: url, completed: nil)
            }
            
            if let backdropPath = movie.backdropPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
                backdropImageView.sd_setImage(with: url, completed: nil)
            }
        } else if let tvShow = viewModel.tvShowDetails {
            titleLabel.text = tvShow.name
            overviewLabel.text = tvShow.overview
            ratingView.configure(rating: tvShow.voteAverage ?? 0.0, voteCount: tvShow.voteCount ?? 0)
            genresLabel.text = viewModel.getFormattedGenres()
            runtimeLabel.isHidden = true
            releaseDateLabel.text = viewModel.getFormattedReleaseDate()
            infoStackView.trailingToSuperview(offset: 75)

            
            if let posterPath = tvShow.posterPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                posterImageView.sd_setImage(with: url, completed: nil)
            }
            
            if let backdropPath = tvShow.backdropPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
                backdropImageView.sd_setImage(with: url, completed: nil)
            }
        }
        
        if viewModel.credits != nil {
            castLabel.text = "Cast: \(viewModel.getFormattedCast())"
            directorLabel.text = "Director: \(viewModel.getDirector())"
        } else if viewModel.tvCredits != nil {
            castLabel.text = "Cast: \(viewModel.getFormattedCast())"
            directorLabel.text = "\(viewModel.getDirector())"
        }
    }
    
    @objc private func watchTrailerTapped() {
        if let videoID = viewModel.videoID {
            guard let url = URL(string: "https://www.youtube.com/watch?v=\(videoID)") else {
                showAlert(title: "Trailer Unavailable", message: "Invalid video URL.")
                return
            }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        } else {
            showAlert(title: "Trailer Unavailable", message: "Sorry, the trailer is not available at the moment.")
        }
    }
    
    private func showError(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
