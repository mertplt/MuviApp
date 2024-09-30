//
//  MovieService.swift
//  MovieApp
//
//  Created by Mert Polat on 30.07.24.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovieDetails(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func fetchMovieCredits(for movieId: Int, completion: @escaping (Result<Credits, Error>) -> Void)
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchDiscoverMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    private let apiKey: String

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, apiKey: String = Config.shared.apiKey ?? "") {
        self.networkManager = networkManager
        self.apiKey = apiKey
    }

    func fetchMovieDetails(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let request = GetMovieDetailsRequest(apiKey: apiKey, movieId: movieId)
        networkManager.requestWithAlamofire(for: request, result: completion)
    }

    func fetchMovieCredits(for movieId: Int, completion: @escaping (Result<Credits, Error>) -> Void) {
        let request = GetMovieCreditsRequest(apiKey: apiKey, movieId: movieId)
        networkManager.requestWithAlamofire(for: request, result: completion)
    }

    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let request = GetSearchMoviesRequest(apiKey: apiKey, query: query, page: 1)
        networkManager.requestWithAlamofire(for: request) { (result: Result<BaseResponse<Movie>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchDiscoverMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let request = GetDiscoverMoviesRequest(apiKey: apiKey, page: page)
        networkManager.requestWithAlamofire(for: request) { (result: Result<BaseResponse<Movie>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

