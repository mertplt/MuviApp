//
//  GetPopularMoviesRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

struct GetPopularMoviesRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<Movie>

    var path: String = "movie/popular"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    
    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }
}
