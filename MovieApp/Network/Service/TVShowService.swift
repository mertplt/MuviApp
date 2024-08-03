//
//  TVShowService.swift
//  MovieApp
//
//  Created by Mert Polat on 03.08.24.
//

import Foundation

protocol TVShowServiceProtocol {
    func fetchTVShowDetails(for tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void)
    func fetchTVShowCredits(for tvShowId: Int, completion: @escaping (Result<TVCredits, Error>) -> Void)
}

class TVShowService: TVShowServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    private let apiKey: String
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, apiKey: String = Config.shared.apiKey ?? "") {
        self.networkManager = networkManager
        self.apiKey = apiKey
    }
    
    func fetchTVShowDetails(for tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void) {
        let request = GetTVShowDetailsRequest(apiKey: apiKey, tvShowId: tvShowId)
        networkManager.requestWithAlamofire(for: request) { (result: Result<TVShow, Error>) in
            completion(result)
        }
    }
    
    func fetchTVShowCredits(for tvShowId: Int, completion: @escaping (Result<TVCredits, Error>) -> Void) {
        let request = GetTVShowCreditsRequest(apiKey: apiKey, tvShowId: tvShowId)
        networkManager.requestWithAlamofire(for: request) { (result: Result<TVCredits, Error>) in
            completion(result)
        }
    }
}
