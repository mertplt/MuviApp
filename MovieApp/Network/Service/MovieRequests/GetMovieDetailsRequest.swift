//
//  GetMovieDetailsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

struct GetMovieDetailsRequest: RequestProtocol {
    typealias ResponseType = Movie

    var path: String
    var method: RequestMethod = .get
    var parameters: RequestParameters
    
    init(apiKey: String, movieId: Int) {
        self.path = "movie/\(movieId)"
        self.parameters = ["api_key": apiKey]
    }
}
