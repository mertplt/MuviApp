//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by mert polat on 15.05.2024.
//

import Foundation

class HomeViewModel {
    
    private let router: HomeRouter
    private let networkManager = NetworkManager.shared
    private let apiKey = Config.shared.apiKey
    
    enum Category {
        case featured
        case series
        case films
        case originals
    }
    
    private var currentCategory: Category = .films
    
    private(set) var model: HomeModel = HomeModel(sections: MockData.shared.pageData)
    private(set) var headerImageURL: String?
    private(set) var headerItem: ListItem?

    var updateHandler: (() -> Void)?
    
    init(router: HomeRouter) {
        self.router = router
    }
    
    func fetchInitialData() {
        fetchMovies()
        fetchTVShows()
        fetchOriginal()
        fetchFeatured()
    }
    
    func fetchFeatured() {
        fetchTrendingTVShows()
        fetchPopularMovies()
        fetchTopRatedTVShows()
        fetchNowPlayingMovies()
    }
    
    func fetchTVShows() {
        fetchTrendingTVShows()
        fetchPopularTVShows()
        fetchTopRatedTVShows()
        fetchOnTheAirTVShows()
    }
    
    func fetchMovies() {
        fetchTrendingMovies()
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchNowPlayingMovies()
    }
    
    func fetchOriginal() {
        fetchTrendingMovies()
        fetchPopularTVShows()
        fetchTopRatedMovies()
        fetchOnTheAirTVShows()
    }
    
    func updateCategory(_ category: Category) {
        currentCategory = category
        switch category {
        case .series:
            fetchTVShows()
        case .films:
            fetchMovies()
        case .originals:
            fetchOriginal()
        case .featured:
            fetchFeatured()
        }
    }
    
    func fetchPopularMovies() {
        fetchItems(request: GetPopularMoviesRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.headerItem = items.randomElement()
            self?.headerImageURL = self?.headerItem?.backdrop
            self?.updateItems(with: items, for: .popular([]))
        }
    }
    
    func fetchPopularTVShows() {
        fetchItems(request: GetPopularTVShowsRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.headerItem = items.randomElement()
            self?.headerImageURL = self?.headerItem?.backdrop
            self?.updateItems(with: items, for: .popular([]))
        }
    }
    
    func fetchTrendingMovies() {
        fetchItems(request: GetTrendingMoviesRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.updateItems(with: items, for: .trending([]))
        }
    }
    
    func fetchTrendingTVShows() {
        fetchItems(request: GetTrendingTVShowsRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.updateItems(with: items, for: .trending([]))
        }
    }
    
    func fetchTopRatedMovies() {
        fetchItems(request: GetTopRatedMoviesRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.updateItems(with: items, for: .topRated([]))
        }
    }
    
    func fetchTopRatedTVShows() {
        fetchItems(request: GetTopRatedTVShowsRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.updateItems(with: items, for: .topRated([]))
        }
    }
    
    func fetchNowPlayingMovies() {
        fetchItems(request: GetNowPlayingMoviesRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.updateItems(with: items, for: .nowPlaying([]))
        }
    }
    
    func fetchOnTheAirTVShows() {
        fetchItems(request: GetOnTheAirTVShowsRequest(apiKey: apiKey ?? "", page: 1)) { [weak self] items in
            self?.updateItems(with: items, for: .nowPlaying([]))
        }
    }
    
    private func fetchItems<T: RequestProtocol>(request: T, completion: @escaping ([ListItem]) -> Void) {
        guard apiKey != nil else {
            print("API Key is missing")
            return
        }
        
        networkManager.requestWithAlamofire(for: request) { result in
            switch result {
            case .success(let response):
                let items = (response as? BaseResponse<Movie>)?.results.map { movie in
                    ListItem(id: movie.id, title: movie.title, image: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? ""), backdrop: movie.backdropPath != nil ? "https://image.tmdb.org/t/p/w780" + movie.backdropPath! : nil, movie: movie, tvShow: nil, firstAirDate: nil, lastAirDate: nil, voteAverage: movie.voteAverage, releaseDate: movie.releaseDate, addedDate: Date())
                } ?? (response as? BaseResponse<TVShow>)?.results.map { tvShow in
                    ListItem(id: tvShow.id, title: tvShow.name, image: "https://image.tmdb.org/t/p/w500" + (tvShow.posterPath ?? ""), backdrop: tvShow.backdropPath != nil ? "https://image.tmdb.org/t/p/w780" + tvShow.backdropPath! : nil, movie: nil, tvShow: tvShow, firstAirDate: tvShow.firstAirDate, lastAirDate: tvShow.lastAirDate, voteAverage: tvShow.voteAverage, releaseDate: nil, addedDate: Date())
                } ?? []
                completion(items)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    private func updateItems(with items: [ListItem], for section: ListSection) {
        if let index = model.sections.firstIndex(where: { $0.title == section.title }) {
            switch section {
            case .stories: model.sections[index] = .stories(items)
            case .popular: model.sections[index] = .popular(items)
            case .trending: model.sections[index] = .trending(items)
            case .topRated: model.sections[index] = .topRated(items)
            case .nowPlaying: model.sections[index] = .nowPlaying(items)
            }
        } else {
            model.sections.append(section)
        }
        updateHandler?()
    }
}
