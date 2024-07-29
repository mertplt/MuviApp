//
//  DiscoverMoviesRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

struct DiscoverMoviesRequest: RequestProtocol {
    typealias ResponseType = BaseResponse<Title>

    var path: String = "discover/movie"
    var method: RequestMethod = .get
    var parameters: RequestParameters = [:]

    init(apiKey: String, page: Int) {
        parameters["api_key"] = apiKey
        parameters["page"] = page
    }
}
