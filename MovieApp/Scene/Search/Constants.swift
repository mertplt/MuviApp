//
//  Constants.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import Foundation

struct Constants {
    static let base_url = "https://api.themoviedb.org"
    static let YoutubeBaseURl = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedToGetData
}
