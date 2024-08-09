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
    
    private(set) var searchResults: [SearchResult] = [] {
        didSet { self.onSearchResultsChanged?(searchResults) }
    }
    
    var onMoviesChanged: (() -> Void)?
    var onSearchResultsChanged: (([SearchResult]) -> Void)?
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
    
    func search(query: String) {
        let movieRequest = GetSearchMoviesRequest(apiKey: apiKey, query: query, page: 1)
        let tvShowRequest = GetSearchTVShowsRequest(apiKey: apiKey, query: query, page: 1)
        
        fetchMovies(with: movieRequest) { [weak self] movieResult in
            self?.fetchTVShows(with: tvShowRequest) { [weak self] tvShowResult in
                self?.processSearchResults(movieResult: movieResult, tvShowResult: tvShowResult)
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
    
    private func fetchTVShows<T: RequestProtocol>(with request: T, completion: @escaping (Result<[TVShow], Error>) -> Void) where T.ResponseType == BaseResponse<TVShow> {
        networkManager.requestWithAlamofire(for: request) { (result: Result<BaseResponse<TVShow>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func processSearchResults(movieResult: Result<[Movie], Error>, tvShowResult: Result<[TVShow], Error>) {
        switch (movieResult, tvShowResult) {
        case (.success(let movies), .success(let tvShows)):
            searchResults = movies.map { SearchResult(type: .movie, item: $0) } + tvShows.map { SearchResult(type: .tvShow, item: $0) }
        case (.failure(let error), _):
            onErrorOccurred?(error)
        case (_, .failure(let error)):
            onErrorOccurred?(error)
        default:
            break
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
