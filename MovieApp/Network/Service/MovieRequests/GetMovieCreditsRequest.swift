//
//  GetMovieCreditsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 30.07.24.
//

import Foundation

struct GetMovieCreditsRequest: RequestProtocol {
    typealias ResponseType = Credits

    var path: String
    var method: RequestMethod = .get
    var parameters: RequestParameters
    
    init(apiKey: String, movieId: Int) {
        self.path = "movie/\(movieId)/credits"
        self.parameters = ["api_key": apiKey]
    }
}
