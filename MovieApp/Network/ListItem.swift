//
//  ListItem.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import Foundation

struct ListItem: Codable {
    let id: Int
    let title: String
    let image: String
    let backdrop: String?
    let movie: Movie?
    let tvShow: TVShow?
    let firstAirDate: String?
    let lastAirDate: String?
    let voteAverage: Double?
    let releaseDate: String?
    let addedDate: Date?

}
