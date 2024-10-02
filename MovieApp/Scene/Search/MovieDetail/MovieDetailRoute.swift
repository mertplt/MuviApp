//
//  MovieDetailRoute.swift
//  MovieApp
//
//  Created by Mert Polat on 04.08.24.
//

//import UIKit
//
//protocol MovieDetailRoute {
//    func placeOnMovieDetailViewController(id: Int, isMovie: Bool)
//}
//
//extension MovieDetailRoute where Self: RouterProtocol {
//    func placeOnMovieDetailViewController(id: Int, isMovie: Bool) {
//        let router = MovieDetailRouter()
//        let viewModel = TitlePreviewViewModel(movieService: MovieService(), youtubeService: YoutubeService(), tvShowService: TVShowService())
//        let ViewController = TitlePreviewViewController(viewModel: viewModel)
//        router.presentingViewController = ViewController
//
//        let navigationController = UINavigationController(rootViewController: ViewController)
//        let transition = PlaceOnWindowTransition()
//        open(navigationController, transition: transition)
//    }
//}
