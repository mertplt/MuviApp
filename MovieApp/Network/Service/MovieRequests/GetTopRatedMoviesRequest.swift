//
//  GetTopRatedMoviesRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 19.07.24.
//

import Foundation

struct GetTopRatedMoviesRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<Movie>

    var path: String = "movie/top_rated"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    
    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }
}
