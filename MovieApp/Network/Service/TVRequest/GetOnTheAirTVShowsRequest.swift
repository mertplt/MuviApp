//
//  GetOnTheAirTVShowsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 19.07.24.
//

import Foundation

struct GetOnTheAirTVShowsRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<TVShow>

    var path: String = "tv/on_the_air"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    
    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }
}
