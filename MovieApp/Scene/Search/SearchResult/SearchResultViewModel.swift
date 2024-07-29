//
//  SearchResultViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 28.07.24.
//

import Foundation

import Foundation

class SearchResultViewModel {
    private(set) var movies: [Movie] = [] {
        didSet {
            self.onMoviesChanged?()
        }
    }
    
    var onMoviesChanged: (() -> Void)?
    
    func updateMovies(_ newMovies: [Movie]) {
        self.movies = newMovies
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
}
