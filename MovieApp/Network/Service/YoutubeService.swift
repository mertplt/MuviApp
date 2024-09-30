//
//  YoutubeService.swift
//  MovieApp
//
//  Created by Mert Polat on 30.07.24.
//

import Foundation

protocol YoutubeServiceProtocol {
    func fetchVideoID(for title: String, completion: @escaping (Result<String, Error>) -> Void)
}

class YoutubeService: YoutubeServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    private let apiKey: String

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, apiKey: String = Config.shared.youtubeApiKey ?? "") {
        self.networkManager = networkManager
        self.apiKey = apiKey
    }

    func fetchVideoID(for title: String, completion: @escaping (Result<String, Error>) -> Void) {
        let request = GetTrailerRequest(apiKey: apiKey, query: title)
        networkManager.requestWithAlamofire(for: request) { (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let response):
                if let videoID = response.items.first?.id.videoId {
                    completion(.success(videoID))
                } else {
                    completion(.failure(NSError(domain: "No video found", code: -1, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
