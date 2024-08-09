//
//  SearchResultViewController.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultViewController: UIViewController {
    private let viewModel = SearchResultViewModel()
    weak var delegate: SearchResultViewControllerDelegate?
    
    public let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorManager.surfaceDark
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
    private func setupBindings() {
        viewModel.onMoviesChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.searchResultCollectionView.reloadData()
            }
        }
    }
    
    public func updateSearchResults(_ results: [SearchResult]) {
        viewModel.updateMovies(results)
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let result = viewModel.result(at: indexPath.row)
        if let movie = result.item as? Movie {
            cell.configure(with: movie.posterPath ?? "")
        } else if let tvShow = result.item as? TVShow {
            cell.configure(with: tvShow.posterPath ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let result = viewModel.result(at: indexPath.row)
        let titlePreviewViewModel = TitlePreviewViewModel(movieService: MovieService(), youtubeService: YoutubeService(), tvShowService: TVShowService())
        
        switch result.type {
        case .movie:
            guard let movie = result.item as? Movie else { return }
            titlePreviewViewModel.fetchMovieDetails(for: movie.id)
        case .tvShow:
            guard let tvShow = result.item as? TVShow else { return }
            titlePreviewViewModel.fetchTVShowDetails(for: tvShow.id)
        }
        
        delegate?.searchResultViewControllerDidTapItem(titlePreviewViewModel)
    }
}

#Preview{
    SearchResultViewController()
}
