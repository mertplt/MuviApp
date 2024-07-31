//
//  Credits.swift
//  MovieApp
//
//  Created by Mert Polat on 30.07.24.
//

import Foundation

struct Credits: Codable {
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable {
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

struct Crew: Codable {
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
