//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 24.07.24.
//

// SearchViewModel.swift

import Foundation

class SearchViewModel {
    private let movieService: MovieServiceProtocol
    private let tvShowService: TVShowServiceProtocol

    private(set) var movies: [Movie] = [] {
        didSet { self.onMoviesChanged?() }
    }

    private(set) var searchResults: [SearchResult] = [] {
        didSet { self.onSearchResultsChanged?(searchResults) }
    }

    var onMoviesChanged: (() -> Void)?
    var onSearchResultsChanged: (([SearchResult]) -> Void)?
    var onErrorOccurred: ((Error) -> Void)?

    init(movieService: MovieServiceProtocol, tvShowService: TVShowServiceProtocol) {
        self.movieService = movieService
        self.tvShowService = tvShowService
    }

    func fetchDiscoverMovies() {
        movieService.fetchDiscoverMovies(page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                self?.onErrorOccurred?(error)
            }
        }
    }

    func search(query: String) {
        let dispatchGroup = DispatchGroup()

        var moviesResult: Result<[Movie], Error>?
        var tvShowsResult: Result<[TVShow], Error>?

        dispatchGroup.enter()
        movieService.searchMovies(query: query) { result in
            moviesResult = result
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        tvShowService.searchTVShows(query: query) { result in
            tvShowsResult = result
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.processSearchResults(movieResult: moviesResult, tvShowResult: tvShowsResult)
        }
    }

    private func processSearchResults(movieResult: Result<[Movie], Error>?, tvShowResult: Result<[TVShow], Error>?) {
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
}
