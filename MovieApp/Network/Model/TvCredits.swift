//
//  TvCredits.swift
//  MovieApp
//
//  Created by Mert Polat on 03.08.24.
//

import Foundation

struct TVCredits: Codable {
    let cast: [TVCast]
    let crew: [TVCrew]
    let guestStars: [TVGuestStar]?
    let directors: [TVCrew]?
    let writers: [TVCrew]?
    
    enum CodingKeys: String, CodingKey {
        case cast
        case crew
        case guestStars = "guest_stars"
        case directors
        case writers
    }
}

struct TVCast: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}

struct TVCrew: Codable {
    let id: Int
    let name: String
    let department: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case department
        case job
    }
}

struct TVGuestStar: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}
