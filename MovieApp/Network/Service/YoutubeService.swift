//
//  YoutubeService.swift
//  MovieApp
//
//  Created by Mert Polat on 30.07.24.
//

import Foundation

class YoutubeService {
    private let networkManager: NetworkManagerProtocol
    private let apiKey: String
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, apiKey: String = Config.shared.youtubeApiKey ?? "") {
        self.networkManager = networkManager
        self.apiKey = apiKey
    }
    
    func fetchVideoID(for query: String, completion: @escaping (Result<String, Error>) -> Void) {
        let request = GetTrailerRequest(apiKey: apiKey, query: query)
        networkManager.requestWithAlamofire(for: request) { (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let response):
                if let videoID = response.items.first?.id.videoId {
                    completion(.success(videoID))
                } else {
                    completion(.failure(APIError.failedToGetData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
