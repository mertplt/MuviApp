//
//  MockData.swift
//  MovieApp
//
//  Created by Mert Polat on 2.07.2024.
//

import Foundation

struct MockData {
    static let shared = MockData()
    
    private let stories: ListSection = {
        .stories([.init(title: "Naruto", image: ""),
                  .init(title: "Itadori", image: ""),
                  .init(title: "Kakashi", image: ""),
                  .init(title: "Tanjiro", image: ""),
                  .init(title: "Nezuko", image: ""),
                  .init(title: "Sasuke", image: ""),
                  .init(title: "Sakura", image: ""),
                  .init(title: "Inosuke", image: "")])
    }()
    
    private let popular: ListSection = {
        .popular([.init(title: "Naruto", image: "moana"),
                  .init(title: "Jujutsu Kaisen", image: "moana"),
                  .init(title: "Demon Slayer", image: "spider"),
                  .init(title: "One Piece", image: "moana"),
                  .init(title: "Seven Deadly Sins", image: "spider")])
    }()
    
    private let comingSoon: ListSection = {
        .comingSoon([.init(title: "Tokyo Ghoul", image: "spider"),
                     .init(title: "Record of Ragnarok", image: "moana"),
                     .init(title: "Kaisen Returns", image: "spider"),
                     .init(title: "No Idea", image: "moana"),
                     .init(title: "Looks interesting", image: "spider")])
    }()
    
    private let upcoming: ListSection = {
        .upcoming([.init(title: "Naruto", image: "spider"),
                  .init(title: "Jujutsu Kaisen", image: "moana"),
                  .init(title: "Demon Slayer", image: "moana"),
                  .init(title: "One Piece", image: "spider"),
                  .init(title: "Seven Deadly Sins", image: "moana")])
    }()
    var pageData: [ListSection] {
        [stories, popular, upcoming, comingSoon]
    }
}
