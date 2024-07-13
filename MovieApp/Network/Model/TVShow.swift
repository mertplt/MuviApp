//
//  TVShow.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

struct TVShow: Decodable {
    let id: Int
    let name: String
    let overview: String
    let firstAirDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case firstAirDate = "first_air_date"
    }
}
