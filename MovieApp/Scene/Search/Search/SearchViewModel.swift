//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 24.07.24.
//

import Foundation

class SearchViewModel {
    private let networkManager = NetworkManager.shared
    private let apiKey = Config.shared.apiKey
    
    private(set) var movies: [Movie] = [] {
        didSet {
            self.onMoviesChanged?()
        }
    }
    
    private(set) var searchResults: [Movie] = [] {
        didSet {
            self.onSearchResultsChanged?(searchResults)
        }
    }
    
    private(set) var error: Error? {
        didSet {
            self.onErrorOccurred?()
        }
    }
    
    var onMoviesChanged: (() -> Void)?
    var onSearchResultsChanged: (([Movie]) -> Void)?
    var onErrorOccurred: (() -> Void)?
    
    func fetchDiscoverMovies() {
        let request = GetDiscoverMoviesRequest(apiKey: apiKey ?? "", page: 1)
        networkManager.requestWithAlamofire(for: request) { [weak self] (result: Result<BaseResponse<Movie>, Error>) in
            switch result {
            case .success(let response):
                self?.movies = response.results
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    func searchMovies(query: String) {
        let request = GetSearchMoviesRequest(apiKey: apiKey ?? "", query: query, page: 1)
        networkManager.requestWithAlamofire(for: request) { [weak self] (result: Result<BaseResponse<Movie>, Error>) in
            switch result {
            case .success(let response):
                self?.searchResults = response.results
            case .failure(let error):
                self?.error = error
            }
        }
    }
}
