//
//  TitlePreviewViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import Foundation

class TitlePreviewViewModel {
    let title: String
    let titleOverview: String
    private var videoID: String?
    private let youtubeApiKey = Config.shared.youtubeApiKey

    init(title: String, titleOverview: String, videoID: String? = nil) {
        self.title = title
        self.titleOverview = titleOverview
        self.videoID = videoID
    }
    
    func fetchYoutubeVideo(for title: String, completion: @escaping (Result<String, Error>) -> Void) {
        let query = "\(title) official trailer video"
        let request = GetMovieTrailerRequest(apiKey: youtubeApiKey ?? "", query: query)
        NetworkManager.shared.requestWithAlamofire(for: request) { [weak self] (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let youtubeResult):
                guard let videoID = youtubeResult.items.first?.id.videoId else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                self?.videoID = videoID
                completion(.success(videoID))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getVideoID() -> String? {
        return videoID
    }
}
