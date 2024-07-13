//
//  Movie.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
    }
}
