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
    private let tvShowService: TVShowService
    
    private(set) var movieDetails: Movie?
    private(set) var tvShowDetails: TVShow?
    private(set) var credits: Credits?
    private(set) var tvCredits: TVCredits?
    private(set) var videoID: String?
    
    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(movieService: MovieService, youtubeService: YoutubeService, tvShowService: TVShowService) {
        self.movieService = movieService
        self.youtubeService = youtubeService
        self.tvShowService = tvShowService
    }
    
    func fetchMovieDetails(for movieId: Int) {
        movieService.fetchMovieDetails(for: movieId) { [weak self] result in
            switch result {
            case .success(let    movie):
                self?.movieDetails = movie
                self?.onDataUpdated?()
                self?.fetchMovieCredits(for: movieId)
                self?.fetchYoutubeVideo(for: movie.title)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func fetchTVShowDetails(for tvShowId: Int) {
        tvShowService.fetchTVShowDetails(for: tvShowId) { [weak self] result in
            switch result {
            case .success(let tvShow):
                self?.tvShowDetails = tvShow
                self?.onDataUpdated?()
                self?.fetchTVShowCredits(for: tvShowId)
                self?.fetchYoutubeVideo(for: tvShow.name)
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
    
    func fetchTVShowCredits(for tvShowId: Int) {
        tvShowService.fetchTVShowCredits(for: tvShowId) { [weak self] result in
            switch result {
            case .success(let tvCredits):
                self?.tvCredits = tvCredits
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
        if let movie = movieDetails {
            return movie.genres?.map { $0.name }.joined(separator: ", ") ?? "N/A"
        } else if let tvShow = tvShowDetails {
            return tvShow.genres?.map { $0.name }.joined(separator: ", ") ?? "N/A"
        }
        return "N/A"
    }
    
    func getFormattedRuntime() -> String {
        guard let runtime = movieDetails?.runtime else { return "N/A" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    func getFormattedCast() -> String {
        if let credits = credits {
            return credits.cast.prefix(5).map { $0.name }.joined(separator: ", ")
        } else if let tvCredits = tvCredits {
            return tvCredits.cast.prefix(5).map { $0.name }.joined(separator: ", ")
        }
        return "N/A"}
    
    func getDirector() -> String {
        if let credits = credits {
            return credits.crew.first(where: { $0.job == "Director" })?.name ?? "N/A"
        } else if let tvShowDetails = tvShowDetails {
            return "\(String(describing: tvShowDetails.numberOfSeasons!)) Season, \(String(describing: tvShowDetails.numberOfEpisodes!)) Episodes"
        }
        return "N/A"
    }
    
    func getFormattedReleaseDate() -> String {
        if let movie = movieDetails {
            guard let releaseDate = movie.releaseDate else { return "N/A" }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = dateFormatter.date(from: releaseDate) else { return "N/A" }
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: date)
        } else if let tvShow = tvShowDetails {
            guard let releaseDate = tvShow.firstAirDate else { return "N/A" }
            guard let lastReleaseDate = tvShow.lastAirDate else { return "N/A" }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = dateFormatter.date(from: releaseDate) else { return "N/A" }
            guard let lastDate = dateFormatter.date(from: lastReleaseDate) else { return "N/A" }
            
            dateFormatter.dateFormat = "yyyy"
            let formattedFirstDate = dateFormatter.string(from: date)
            let formattedLastDate = dateFormatter.string(from: lastDate)
            
            return "\(formattedFirstDate) - \(formattedLastDate)"
        }
        
        return "N/A"
    }
}
