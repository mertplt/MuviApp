//
//  MovieService.swift
//  MovieApp
//
//  Created by Mert Polat on 30.07.24.
//

import Foundation

class MovieService {
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
}
