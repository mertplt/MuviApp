//
//  SearchView.swift
//  MovieApp
//
//  Created by Mert Polat on 30.06.2024.
//

import UIKit

final class SearchViewController: UIViewController, SearchResultViewControllerDelegate {


    private let viewModel = SearchViewModel()
    private let searchResultViewController = SearchResultViewController()

    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifer)
        table.backgroundColor = ColorManager.surfaceDark
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: searchResultViewController)
        controller.searchBar.placeholder = "Search for a Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.tintColor = .white
        
        let textFieldInsideSearchBar = controller.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Search for a Movie or a Tv show", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)])

        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.fetchDiscoverMovies()
    }
    
    private func setupUI() {
        view.backgroundColor = ColorManager.surfaceDark
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        configureNavigationBar()
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchResultViewController.delegate = self
    }
    
    private func setupBindings() {
        viewModel.onMoviesChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.discoverTable.reloadData()
            }
        }
        
        viewModel.onErrorOccurred = { [weak self] in
            DispatchQueue.main.async {
                if let error = self?.viewModel.error {
                    print("Error occurred: \(error.localizedDescription)")
                }
            }
        }
        
        viewModel.onSearchResultsChanged = { [weak self] movies in
             DispatchQueue.main.async {
                 self?.searchResultViewController.updateSearchResults(movies)
             }
         }
    }
    
    func searchResultViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifer, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.movies[indexPath.row]
        let listItem = ListItem(title: movie.title, image: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")", backdrop: movie.backdropPath)
        cell.setup(listItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = viewModel.movies[indexPath.row]
        let viewModel = TitlePreviewViewModel(title: movie.title, titleOverview: movie.overview)
        
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            return
        }
        
        viewModel.searchMovies(query: query)
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset > 0 {
            UIView.animate(withDuration: 0.3) {
                self.navigationController?.navigationBar.standardAppearance.backgroundColor = ColorManager.surfaceDark
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = ColorManager.surfaceDark
                self.navigationController?.navigationBar.compactAppearance?.backgroundColor = ColorManager.surfaceDark
                self.navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: ColorManager.surfaceDark]
                self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: ColorManager.surfaceDark]
                self.navigationController?.navigationBar.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .clear
                self.navigationController?.navigationBar.compactAppearance?.backgroundColor = .clear
                self.navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.layoutIfNeeded()
            }
        }
    }
}

#Preview {
    SearchViewController()
}
