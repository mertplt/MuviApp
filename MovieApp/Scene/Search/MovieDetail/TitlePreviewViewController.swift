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

class TitlePreviewViewController: UIViewController {
    private var viewModel: TitlePreviewViewModel
    
    init(viewModel: TitlePreviewViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = ColorManager.surfaceLight
        label.numberOfLines = 0
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = ColorManager.surfaceLight
        label.textColor = .gray
        return label
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = ColorManager.surfaceLight
        label.textColor = .gray
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorManager.surfaceLight
        label.numberOfLines = 0
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = ColorManager.surfaceLight
        label.textColor = ColorManager.surfaceLight
        label.numberOfLines = 0
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = ColorManager.surfaceLight
        return label
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        
        contentView.addSubview(webView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(runtimeLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(directorLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.edgesToSuperview()
        contentView.edgesToSuperview()
        contentView.width(to: scrollView)
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        webView.topToSuperview(offset: 20)
        webView.leadingToSuperview(offset: 20)
        webView.trailingToSuperview(offset: 20)
        webView.height(250)
        
        posterImageView.topToBottom(of: webView, offset: 20)
        posterImageView.centerXToSuperview()
        posterImageView.width(200)
        posterImageView.height(300)
        
        titleLabel.topToBottom(of: posterImageView, offset: 20)
        titleLabel.leadingToSuperview(offset: 20)
        titleLabel.trailingToSuperview(offset: 20)
        
        genresLabel.topToBottom(of: titleLabel, offset: 10)
        genresLabel.leadingToSuperview(offset: 20)
        genresLabel.trailingToSuperview(offset: 20)
        
        runtimeLabel.topToBottom(of: genresLabel, offset: 5)
        runtimeLabel.leadingToSuperview(offset: 20)
        runtimeLabel.trailingToSuperview(offset: 20)
        
        overviewLabel.topToBottom(of: runtimeLabel, offset: 20)
        overviewLabel.leadingToSuperview(offset: 20)
        overviewLabel.trailingToSuperview(offset: 20)
        
        castLabel.topToBottom(of: overviewLabel, offset: 20)
        castLabel.leadingToSuperview(offset: 20)
        castLabel.trailingToSuperview(offset: 20)
        
        directorLabel.topToBottom(of: castLabel, offset: 10)
        directorLabel.leadingToSuperview(offset: 20)
        directorLabel.trailingToSuperview(offset: 20)
        directorLabel.bottomToSuperview(offset: -20)
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
    
 
    private func updateUI() {
         if let movie = viewModel.movieDetails {
             titleLabel.text = movie.title
             overviewLabel.text = movie.overview
             genresLabel.text = viewModel.getFormattedGenres()
             runtimeLabel.text = viewModel.getFormattedRuntime()
             
             if let posterPath = movie.posterPath {
                 let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                 posterImageView.sd_setImage(with: url, completed: nil)
             }
         }
         
         if let credits = viewModel.credits {
             castLabel.text = "Cast: \(viewModel.getFormattedCast())"
             directorLabel.text = "Director: \(viewModel.getDirector())"
         }
         
         if let videoID = viewModel.videoID {
             configureWebView(with: videoID)
         }
     }
        
    private func configureWebView(with videoID: String) {
         guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
             print("Invalid video URL")
             return
         }
         webView.load(URLRequest(url: url))
     }
     
     private func showError(_ error: Error) {
         let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alert, animated: true, completion: nil)
     }
    
}
