//
//  GetTrendingMoviesRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 18.07.24.
//

import Foundation

struct GetTrendingMoviesRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<Movie>

    var path: String = "trending/movie/week"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    
    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }
}
