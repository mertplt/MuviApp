//
//  UserCredits.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import Foundation

// MARK: - CombinedCredits
struct UserCredits: Codable {
    let cast: [CombinedCast]
    let crew: [CombinedCrew]
    let id: Int
}

// MARK: - CombinedCast
struct CombinedCast: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let character: String?
    let creditID: String
    let order: Int?
    let mediaType: MediaType
    
    let originalName: String?
    let firstAirDate: String?
    let name: String?
    let episodeCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order
        case mediaType = "media_type"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case name
        case episodeCount = "episode_count"
    }
}

// MARK: - CombinedCrew
struct CombinedCrew: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let creditID: String
    let department: String
    let job: String
    let mediaType: MediaType
    
    let originalName: String?
    let firstAirDate: String?
    let name: String?
    let episodeCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case creditID = "credit_id"
        case department, job
        case mediaType = "media_type"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case name
        case episodeCount = "episode_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}
