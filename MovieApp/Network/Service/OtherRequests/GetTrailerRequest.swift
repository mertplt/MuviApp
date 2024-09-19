//
//  GetMovieTrailerRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 27.07.24.
//

import Foundation

struct GetTrailerRequest: RequestProtocol {
    typealias ResponseType = YoutubeSearchResponse
    
    var path: String = ""
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    var url: String
    
    init(apiKey: String, query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            fatalError("Invalid query")
        }
        self.url = Constants.YoutubeBaseURl + "q=\(encodedQuery)&key=\(apiKey)"
    }
}
