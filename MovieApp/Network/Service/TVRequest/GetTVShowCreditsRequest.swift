//
//  GetTVShowCreditsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 03.08.24.
//

import Foundation

struct GetTVShowCreditsRequest: RequestProtocol {
    typealias ResponseType = TVCredits
    
    var path: String
    var method: RequestMethod = .get
    var parameters: RequestParameters
    
    init(apiKey: String, tvShowId: Int) {
        self.path = "tv/\(tvShowId)/credits"
        self.parameters = ["api_key": apiKey]
    }
}
