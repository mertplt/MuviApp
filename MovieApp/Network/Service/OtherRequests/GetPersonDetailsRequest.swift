//
//  GetPersonDetailsRequest.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import Foundation

struct GetPersonDetailsRequest: RequestProtocol {
    typealias ResponseType = Person
    
    var path: String
    var method: RequestMethod = .get
    var parameters: RequestParameters
    
    init(apiKey: String, personId: Int) {
        self.path = "person/\(personId)"
        self.parameters = ["api_key": apiKey]
    }
}
