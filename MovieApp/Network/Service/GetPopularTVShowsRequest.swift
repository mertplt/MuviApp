//
//  GetPopularTVShowsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

struct GetPopularTVShowsRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<TVShow>

    var path: String = "tv/popular"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]
    
    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }
}
