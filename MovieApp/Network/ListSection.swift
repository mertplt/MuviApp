//
//  ListSection.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import Foundation

enum ListSection {
    case stories([ListItem])
    case popular([ListItem])
    case trending([ListItem])
    case topRated([ListItem])
    case nowPlaying([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .stories(let items),
             .popular(let items),
             .trending(let items),
             .topRated(let items),
             .nowPlaying(let items):
            return items
        }
    }
    
    var title: String {
        switch self {
        case .stories: return "Stories"
        case .popular: return "Popular"
        case .trending: return "Trending"
        case .topRated: return "Top Rated"
        case .nowPlaying: return "Now Playing"
        }
    }
}
