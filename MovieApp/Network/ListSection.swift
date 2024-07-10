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
    case comingSoon([ListItem])
    case upcoming([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .stories(let items),
                .popular(let items),
                .comingSoon(let items),
                .upcoming(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .stories:
            return "Stories"
        case .popular:
            return "Popular"
        case .comingSoon:
            return "Coming Soon"
        case .upcoming:
            return "Upcoming Movies"
        }
    }
}
