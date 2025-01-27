//
//  GetTVShowDetailsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

struct GetTVShowDetailsRequest: RequestProtocol {
    typealias ResponseType = TVShow
    var path: String
    var method: RequestMethod = .get
    var parameters: RequestParameters
    
    init(apiKey: String, tvShowId: Int) {
        self.path = "tv/\(tvShowId)"
        self.parameters = ["api_key": apiKey]
    }
}
