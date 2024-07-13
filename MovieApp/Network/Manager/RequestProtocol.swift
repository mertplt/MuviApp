//
//  RequestProtocol.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

typealias RequestParameters = [String: Any]
typealias RequestHeaders = [String: String]

protocol RequestProtocol {
    associatedtype ResponseType: Decodable
    
    var url: String { get }
    var path: String { get }
    var headers: RequestHeaders { get }
    var method: RequestMethod { get }
    var parameters: RequestParameters { get }
    var encoding: RequestEncoding { get }
}

extension RequestProtocol {
    var url: String {
        return "https://api.themoviedb.org/3/" + path
    }
    
    var parameters: RequestParameters {
        return [:]
    }
    
    var headers: RequestHeaders {
        return [:]
    }
    
    var encoding: RequestEncoding {
        switch method {
        case .get:
            return .url
        default:
            return .json
        }
    }
}
