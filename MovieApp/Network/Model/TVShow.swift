//
//  TVShow.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

struct TVShow: Decodable {
    let id: Int
    let name: String
    let overview: String
    let firstAirDate: String?
    let lastAirDate: String?
    let posterPath: String?
    let backdropPath: String?
    let genres: [Genre]?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?
    let seasons: [Season]?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let voteCount: Int?
    let voteAverage: Double?
    let tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genres
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case seasons
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case spokenLanguages = "spoken_languages"
        case status
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case tagline
    }
}

struct Season: Decodable {
    let seasonNumber: Int
    let episodeCount: Int
    let airDate: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case seasonNumber = "season_number"
        case episodeCount = "episode_count"
        case airDate = "air_date"
        case posterPath = "poster_path"
    }
}
