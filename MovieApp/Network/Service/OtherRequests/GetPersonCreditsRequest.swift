//
//  GetPersonCreditsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import Foundation

struct GetPersonCreditsRequest: RequestProtocol {
    typealias ResponseType = UserCredits
    
    var path: String
    var method: RequestMethod = .get
    var parameters: RequestParameters
    
    init(apiKey: String, personId: Int) {
        self.path = "person/\(personId)/combined_credits"
        self.parameters = ["api_key": apiKey]
    }
}
