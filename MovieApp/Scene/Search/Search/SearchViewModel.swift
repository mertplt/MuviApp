//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 24.07.24.
//

import Foundation

class SearchViewModel {
    private let networkManager: NetworkManagerProtocol
    private let apiKey: String
    private(set) var movie: Movie?
    private(set) var movies: [Movie] = [] {
        didSet { self.onMoviesChanged?() }
    }
    
    private(set) var searchResults: [Movie] = [] {
        didSet { self.onSearchResultsChanged?(searchResults) }
    }
    
    var onMoviesChanged: (() -> Void)?
    var onSearchResultsChanged: (([Movie]) -> Void)?
    var onErrorOccurred: ((Error) -> Void)?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, apiKey: String = Config.shared.apiKey ?? "") {
        self.networkManager = networkManager
        self.apiKey = apiKey
    }
    
    func fetchDiscoverMovies() {
        let request = GetDiscoverMoviesRequest(apiKey: apiKey, page: 1)
        fetchMovies(with: request) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                self?.onErrorOccurred?(error)
            }
        }
    }
    
    func searchMovies(query: String) {
        let request = GetSearchMoviesRequest(apiKey: apiKey, query: query, page: 1)
        fetchMovies(with: request) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.searchResults = movies
            case .failure(let error):
                self?.onErrorOccurred?(error)
            }
        }
    }
    
    private func fetchMovies<T: RequestProtocol>(with request: T, completion: @escaping (Result<[Movie], Error>) -> Void) where T.ResponseType == BaseResponse<Movie> {
        networkManager.requestWithAlamofire(for: request) { (result: Result<BaseResponse<Movie>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFormattedReleaseDate(for movie: Movie) -> String {
        guard let releaseDate = movie.releaseDate else { return "N/A" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else { return "N/A" }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }

}
