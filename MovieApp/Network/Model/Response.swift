//
//  Model.swift
//  MovieApp
//
//  Created by mert polat on 3.02.2024.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct ErrorResponse: Decodable, Error {
    let statusMessage: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
