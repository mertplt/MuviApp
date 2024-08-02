//
//  YoutubeSearchResponse.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
