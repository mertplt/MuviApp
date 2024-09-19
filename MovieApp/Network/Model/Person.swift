//
//  Person.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import Foundation

struct Person: Codable {
    let id: Int
    let name: String
    let alsoKnownAs: [String]?
    let gender: Int?
    let biography: String?
    let birthday: String?
    let placeOfBirth: String?
    let deathday: String?
    let popularity: Double?
    let profilePath: String?
    let adult: Bool?
    let knownForDepartment: String?
    let homepage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case alsoKnownAs = "also_known_as"
        case gender
        case biography
        case birthday
        case placeOfBirth = "place_of_birth"
        case deathday
        case popularity
        case profilePath = "profile_path"
        case adult
        case knownForDepartment = "known_for_department"
        case homepage
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        alsoKnownAs = try container.decodeIfPresent([String].self, forKey: .alsoKnownAs)
        gender = try container.decodeIfPresent(Int.self, forKey: .gender)
        biography = try container.decodeIfPresent(String.self, forKey: .biography)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth)
        deathday = try container.decodeIfPresent(String.self, forKey: .deathday)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        knownForDepartment = try container.decodeIfPresent(String.self, forKey: .knownForDepartment)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
    }
}
