//
//  MockData.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import Foundation

struct MockData {
    static var shared = MockData()
    
    private let stories: ListSection = {
        .stories([
            .init(title: "Naruto", image: "https://via.placeholder.com/104x150", backdrop: nil),
            .init(title: "Itadori", image: "https://via.placeholder.com/104x150", backdrop: nil),
            .init(title: "Kakashi", image: "https://via.placeholder.com/104x150", backdrop: nil),
            .init(title: "Tanjiro", image: "https://via.placeholder.com/104x150", backdrop: nil),
            .init(title: "Nezuko", image: "https://via.placeholder.com/104x150", backdrop: nil),
            .init(title: "Sasuke", image: "https://via.placeholder.com/104x150", backdrop: nil),
            .init(title: "Sakura", image: "https://via.placeholder.com/104x150", backdrop: nil),
            .init(title: "Inosuke", image: "https://via.placeholder.com/104x150", backdrop: nil)
        ])
    }()
    
    private var popular: ListSection = {
        .popular([
            .init(title: "Naruto", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Jujutsu Kaisen", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Demon Slayer", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "One Piece", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Seven Deadly Sins", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439")
        ])
    }()
    
    private var comingSoon: ListSection = {
        .comingSoon([
            .init(title: "Tokyo Ghoul", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Record of Ragnarok", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Kaisen Returns", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "No Idea", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Looks interesting", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439")
        ])
    }()
    
    private var upcoming: ListSection = {
        .upcoming([
            .init(title: "Naruto", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Jujutsu Kaisen", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Demon Slayer", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "One Piece", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439"),
            .init(title: "Seven Deadly Sins", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439")
        ])
    }()
    
    var pageData: [ListSection] {
        [stories, popular, comingSoon, upcoming]
    }
    
    mutating func updatePopularMovies(with movies: [ListItem]) {
        popular = .popular(movies)
    }
    
    mutating func updateComingSoon(with tvShows: [ListItem]) {
        comingSoon = .comingSoon(tvShows)
    }
    
    mutating func updateUpcomingMovies(with tvShows: [ListItem]) {
        upcoming = .upcoming(tvShows)
    }
}
