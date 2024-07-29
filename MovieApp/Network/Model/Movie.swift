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
    let posterPath: String?
    let backdropPath: String?
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let vote_count: Int
    let vote_average: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case media_type
        case original_name
        case original_title
        case vote_count
        case vote_average
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
