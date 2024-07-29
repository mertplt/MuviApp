//
//  GetDiscoverMoviesRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 27.07.24.
//

import Foundation

struct GetDiscoverMoviesRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<Movie>

    var path: String = "discover/movie"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    
    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }
}

