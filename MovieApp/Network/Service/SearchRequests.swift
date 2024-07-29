//
//  SearchRequests.swift
//  MovieApp
//
//  Created by Mert Polat on 24.07.24.
//

import Foundation

struct SearchMoviesRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<Movie>
    var path: String = "search/movie"
    var method: RequestMethod = .get
    var parameters: RequestParameters
    
    init(apiKey: String, query: String, page: Int) {
        self.parameters = [
            "api_key": apiKey,
            "query": query,
            "page": page
        ]
    }
}
