//
//  TitlePreviewViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 22.07.24.
//

import Foundation

class TitlePreviewViewModel {
    private let movieService: MovieService
    private let youtubeService: YoutubeService
    
    private(set) var movieDetails: Movie?
    private(set) var credits: Credits?
    private(set) var videoID: String?
    
    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(movieService: MovieService, youtubeService: YoutubeService) {
        self.movieService = movieService
        self.youtubeService = youtubeService
    }
    
    func fetchMovieDetails(for movieId: Int) {
        movieService.fetchMovieDetails(for: movieId) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movieDetails = movie
                self?.onDataUpdated?()
                self?.fetchMovieCredits(for: movieId)
                self?.fetchYoutubeVideo(for: movie.title)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func fetchMovieCredits(for movieId: Int) {
        movieService.fetchMovieCredits(for: movieId) { [weak self] result in
            switch result {
            case .success(let credits):
                self?.credits = credits
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func fetchYoutubeVideo(for title: String) {
        youtubeService.fetchVideoID(for: title + " trailer") { [weak self] result in
            switch result {
            case .success(let videoID):
                self?.videoID = videoID
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func getFormattedGenres() -> String {
        return movieDetails?.genres?.map { $0.name }.joined(separator: ", ") ?? "N/A"
    }
    
    func getFormattedRuntime() -> String {
        guard let runtime = movieDetails?.runtime else { return "N/A" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    func getFormattedCast() -> String {
        return credits?.cast.prefix(5).map { $0.name }.joined(separator: ", ") ?? "N/A"
    }
    
    func getDirector() -> String {
        return credits?.crew.first(where: { $0.job == "Director" })?.name ?? "N/A"
    }
        
    func getFormattedReleaseDate() -> String {
        guard let releaseDate = movieDetails?.releaseDate else { return "N/A" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else { return "N/A" }
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
