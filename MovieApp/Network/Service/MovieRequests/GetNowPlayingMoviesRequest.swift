//
//  GetNowPlayingMoviesRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 19.07.24.
//

import Foundation

struct GetNowPlayingMoviesRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<Movie>

    var path: String = "movie/now_playing"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    
    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }

}
