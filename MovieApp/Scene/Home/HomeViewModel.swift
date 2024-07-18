//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by mert polat on 15.05.2024.
//

import Foundation

class HomeViewModel {
    var router: HomeRouter
    let networkManager = NetworkManager()
    private let apiKey = Config.shared.apiKey
    
    private(set) var model: HomeModel = HomeModel(sections: MockData.shared.pageData)
    private(set) var headerImageURL: String?

    var updateHandler: (() -> Void)?
    
    init(router: HomeRouter) {
        self.router = router
    }
    
    func fetchPopularMovies() {
        guard let apiKey = apiKey else {
            print("API Key is missing")
            return
        }
        
        let request = GetPopularMoviesRequest(apiKey: apiKey, page: 1)
        
        networkManager.requestWithAlamofire(for: request) { [weak self] result in
            switch result {
            case .success(let response):
                print("Page: \(response.page)")
                let popularMovies = response.results.map { movie in
                    ListItem(title: movie.title, image: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? ""), backdrop: movie.backdropPath != nil ? "https://image.tmdb.org/t/p/w780" + movie.backdropPath! : nil)
                }
                self?.headerImageURL = popularMovies.randomElement()?.backdrop 
                self?.updatePopularMovies(with: popularMovies)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPopularTVShows() {
        guard let apiKey = apiKey else {
            print("API Key is missing")
            return
        }
        
        let request = GetPopularTVShowsRequest(apiKey: apiKey, page: 1)
        
        networkManager.requestWithAlamofire(for: request) { [weak self] result in
            switch result {
            case .success(let response):
                print("Page: \(response.page)")
                let popularTVShows = response.results.map { tvShow in
                    ListItem(title: tvShow.name, image: "https://image.tmdb.org/t/p/w500" + (tvShow.posterPath ?? ""), backdrop: tvShow.backdropPath != nil ? "https://image.tmdb.org/t/p/w780" + tvShow.backdropPath! : nil)
                }
                self?.updatePopularTVShows(with: popularTVShows)
                self?.updateUpcomingMovies(with: popularTVShows)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTrendingMovies() {
        guard let apiKey = apiKey else {
            print("API Key is missing")
            return
        }
        
        let request = GetTrendingMoviesRequest(apiKey: apiKey, page: 1)
        
        networkManager.requestWithAlamofire(for: request) { [weak self] result in
            switch result {
            case .success(let response):
                print("Page: \(response.page)")
                let TrendingMovies = response.results.map { movie in
                    ListItem(title: movie.title, image: "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? ""), backdrop: movie.backdropPath != nil ? "https://image.tmdb.org/t/p/w780" + movie.backdropPath! : nil)
                }
                self?.updateComingSoon(with: TrendingMovies)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func updatePopularMovies(with movies: [ListItem]) {
        if let index = model.sections.firstIndex(where: {
            if case .popular = $0 {
                return true
            }
            return false
        }) {
            model.sections[index] = .popular(movies)
            updateHandler?()
        }
    }
    
    private func updateUpcomingMovies(with tvShows: [ListItem]) {
        if let index = model.sections.firstIndex(where: {
            if case .upcoming = $0 {
                return true
            }
            return false
        }) {
            model.sections[index] = .upcoming(tvShows)
            updateHandler?()
        }
    }
    
    private func updateComingSoon(with movies: [ListItem]) {
        if let index = model.sections.firstIndex(where: {
            if case .comingSoon = $0 {
                return true
            }
            return false
        }) {
            model.sections[index] = .comingSoon(movies)
            updateHandler?()
        }
    }
    
    private func updatePopularTVShows(with tvShows: [ListItem]) {
        if let index = model.sections.firstIndex(where: {
            if case .popularTVShows = $0 {
                return true
            }
            return false
        }) {
            model.sections[index] = .popularTVShows(tvShows)
        } else {
            model.sections.append(.popularTVShows(tvShows))
        }
        updateHandler?()
    }
    
}
