//
//  SearchView.swift
//  MovieApp
//
//  Created by Mert Polat on 30.06.2024.
//

import UIKit
import TinyConstraints

final class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    private let searchResultViewController = SearchResultViewController()
    
    private lazy var discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        table.backgroundColor = ColorManager.surfaceDark
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: searchResultViewController)
        controller.searchBar.placeholder = "Search for a Movie or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.tintColor = .white
        controller.searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        controller.searchBar.setImage(UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .clear, state: .normal)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchDiscoverMovies()
        configureSearchBar()
    }
    
    private func setupUI() {
        view.backgroundColor = ColorManager.surfaceDark
        title = "Search"
        configureNavigationBar()
        view.addSubview(discoverTable)
        discoverTable.edgesToSuperview()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchResultViewController.delegate = self
    }
    
    private func configureSearchBar() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.tintColor = .white
            textField.attributedPlaceholder = NSAttributedString(
                string: "Search for a Movie or a TV show",
                attributes: [.foregroundColor: ColorManager.mediumEmphasis]
            )
            
            textField.backgroundColor = ColorManager.surfaceDark.withAlphaComponent(0.5)
            
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textField.textColor = ColorManager.surfaceLight
    }
    
    private func setupBindings() {
        viewModel.onMoviesChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.discoverTable.reloadData()
            }
        }
        
        viewModel.onErrorOccurred = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
        
        viewModel.onSearchResultsChanged = { [weak self] results in
            DispatchQueue.main.async {
                self?.searchResultViewController.updateSearchResults(results)
            }
        }
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: ColorManager.surfaceLight]
        appearance.titleTextAttributes = [.foregroundColor: ColorManager.surfaceLight]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = ColorManager.surfaceLight
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureSearchBarTextField(_ searchBar: UISearchBar) {
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = ColorManager.surfaceLight
            textField.attributedPlaceholder = NSAttributedString(
                string: "Search for a Movie or a TV show",
                attributes: [.foregroundColor: ColorManager.surfaceLight.withAlphaComponent(0.7)]
            )
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movies[indexPath.row]
        presentTitlePreviewViewController(for: movie)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            return
        }
        
        viewModel.search(query: query)
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        updateNavigationBarAppearance(for: offset)
    }
    
    private func updateNavigationBarAppearance(for offset: CGFloat) {
        let backgroundColor: UIColor = offset > 0 ? ColorManager.surfaceDark : .clear
        let textColor: UIColor = offset > 0 ? ColorManager.surfaceDark : ColorManager.surfaceLight
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = backgroundColor
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = backgroundColor
            self.navigationController?.navigationBar.compactAppearance?.backgroundColor = backgroundColor
            self.navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]
            self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: textColor]
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
    }
}

extension SearchViewController: SearchResultViewControllerDelegate {
    func searchResultViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController(viewModel: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchViewController {
    private func presentTitlePreviewViewController(for movie: Movie) {
        let titlePreviewViewModel = TitlePreviewViewModel(movieService: MovieService(), youtubeService: YoutubeService(), tvShowService: TVShowService())
        titlePreviewViewModel.fetchMovieDetails(for: movie.id)
        
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController(viewModel: titlePreviewViewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
#Preview {
    SearchViewController()
}
