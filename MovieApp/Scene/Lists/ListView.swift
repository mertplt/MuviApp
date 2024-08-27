//
//  ListView.swift
//  MovieApp
//
//  Created by Mert Polat on 30.06.2024.
//

import UIKit

class ListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ColorManager.surfaceDark
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()
    
    private var listItems: [ListItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        view.backgroundColor = ColorManager.surfaceDark
        setupUI()
        loadListItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadListItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if listItems.isEmpty {
            loadListItems()
        }
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadListItems() {
        ListViewModel.shared.getList { [weak self] items in
            guard let self = self else { return }
            self.listItems = items
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        let item = listItems[indexPath.row]
        if let movie = item.movie {
            cell.configure(with: movie)
        } else if let tvShow = item.tvShow {
            cell.configure(with: tvShow)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = listItems[indexPath.row]
        let viewModel = TitlePreviewViewModel(movieService: MovieService(), youtubeService: YoutubeService(), tvShowService: TVShowService())
        
        if let movie = item.movie {
            viewModel.fetchMovieDetails(for: movie.id)
        } else if let tvShow = item.tvShow {
            viewModel.fetchTVShowDetails(for: tvShow.id)
        }
        
        let titlePreviewVC = TitlePreviewViewController(viewModel: viewModel)
        navigationController?.pushViewController(titlePreviewVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115     }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = listItems[indexPath.row]
            ListViewModel.shared.removeFromList(item)
            loadListItems()
        }
    }
}

extension ListView {
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
}
