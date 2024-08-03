//
//  SearchResultViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 28.07.24.
//

import Foundation

class SearchResultViewModel {
    private(set) var results: [SearchResult] = [] {
        didSet {
            self.onMoviesChanged?()
        }
    }
    
    var onMoviesChanged: (() -> Void)?
    
    func updateMovies(_ newResults: [SearchResult]) {
        self.results = newResults
    }
    
    func result(at index: Int) -> SearchResult {
        return results[index]
    }
}

enum SearchResultType {
    case movie
    case tvShow
}

struct SearchResult {
    let type: SearchResultType
    let item: Any
}
