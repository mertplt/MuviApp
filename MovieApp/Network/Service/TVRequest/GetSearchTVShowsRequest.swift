//
//  GetSearchTVShowsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 03.08.24.
//

import Foundation

struct GetSearchTVShowsRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<TVShow>
    var path: String = "search/tv"
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
