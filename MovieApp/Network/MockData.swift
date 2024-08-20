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
            .init(id: 1, title: "Featured", image: "https://via.placeholder.com/104x150", backdrop: nil, movie: nil, tvShow: nil),
            .init(id: 1, title: "Series", image: "https://via.placeholder.com/104x150", backdrop: nil, movie: nil, tvShow: nil),
            .init(id: 1, title: "Films", image: "https://via.placeholder.com/104x150", backdrop: nil, movie: nil, tvShow: nil),
            .init(id: 1, title: "Originals", image: "https://via.placeholder.com/104x150", backdrop: nil, movie: nil, tvShow: nil),
        ])
    }()
    
    private var popular: ListSection = {
        .popular([
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/335x189", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil)
        ])
    }()
    
    private var trending: ListSection = {
        .trending([
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x135", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil)
        ])
    }()
    
    private var topRated: ListSection = {
        .topRated([
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name Sins", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil)
        ])
    }()
    
    private var nowPlaying: ListSection = {
        .nowPlaying([
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil),
            .init(id: 1, title: "Movie Name", image: "https://via.placeholder.com/240x136", backdrop: "https://via.placeholder.com/780x439", movie: nil, tvShow: nil)
        ])
    }()
    
    var pageData: [ListSection] {
        [stories, trending, popular , topRated, nowPlaying]
    }
    
    mutating func updatePopularMovies(with movies: [ListItem]) {
        popular = .popular(movies)
    }
    
    mutating func updateTrendingMovies(with movies: [ListItem]) {
        trending = .trending(movies)
    }
    
    mutating func updateTopRatedMovies(with movies: [ListItem]) {
        topRated = .topRated(movies)
    }
    
    mutating func updateNowPlayingMovies(with movies: [ListItem]) {
        nowPlaying = .nowPlaying(movies)
    }
}
