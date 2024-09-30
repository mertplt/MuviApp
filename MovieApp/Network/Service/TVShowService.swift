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
    func searchTVShows(query: String, completion: @escaping (Result<[TVShow], Error>) -> Void)
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
        networkManager.requestWithAlamofire(for: request, result: completion)
    }

    func fetchTVShowCredits(for tvShowId: Int, completion: @escaping (Result<TVCredits, Error>) -> Void) {
        let request = GetTVShowCreditsRequest(apiKey: apiKey, tvShowId: tvShowId)
        networkManager.requestWithAlamofire(for: request, result: completion)
    }

    func searchTVShows(query: String, completion: @escaping (Result<[TVShow], Error>) -> Void) {
        let request = GetSearchTVShowsRequest(apiKey: apiKey, query: query, page: 1)
        networkManager.requestWithAlamofire(for: request) { (result: Result<BaseResponse<TVShow>, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

