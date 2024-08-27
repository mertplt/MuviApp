//
//  ListViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 08.08.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ListViewModel {
    static let shared = ListViewModel()
    
    private let db = Firestore.firestore()
    private var currentUserID: String?
    
    private init() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.currentUserID = user?.uid
        }
    }
    
    func addToList(_ item: ListItem) {
        guard let userID = currentUserID else { return }
        
        db.collection("users").document(userID).collection("list").document(String(item.id)).setData([
            "id": item.id,
            "title": item.title,
            "image": item.image,
            "vote_average": item.voteAverage ?? 0,
            "first_air_date": item.firstAirDate ?? "",
            "last_air_date": item.lastAirDate ?? "",
            "release_date": item.releaseDate ?? "",
            "backdrop": item.backdrop ?? "",
            "isMovie": item.movie != nil
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
        }
    }
    
    func removeFromList(_ item: ListItem) {
        guard let userID = currentUserID else { return }
        
        db.collection("users").document(userID).collection("list").document(String(item.id)).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            }
        }
    }
    
    func getList(completion: @escaping ([ListItem]) -> Void) {
        guard let userID = currentUserID else {
            completion([])
            return
        }
        
        db.collection("users").document(userID).collection("list").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion([])
            } else {
                let listItems = querySnapshot?.documents.compactMap { document -> ListItem? in
                    let data = document.data()
                    guard let id = data["id"] as? Int,
                          let title = data["title"] as? String,
                          let image = data["image"] as? String,
                          let isMovie = data["isMovie"] as? Bool else {
                        return nil
                    }
                    
                    let backdrop = data["backdrop"] as? String
                    let voteAverage = data["vote_average"] as? Double
                    let firstAirDate = data["first_air_date"] as? String
                    let lastAirDate = data["last_air_date"] as? String
                    let releaseDate = data["release_date"] as? String
                    
                    if isMovie {
                        let movie = Movie(id: id, title: title, overview: "", releaseDate: releaseDate ?? "", posterPath: image, backdropPath: backdrop, mediaType: nil, originalName: nil, originalTitle: nil, voteCount: nil, voteAverage: voteAverage, genres: nil, runtime: nil, productionCompanies: nil, productionCountries: nil, spokenLanguages: nil, status: nil, tagline: nil)
                        return ListItem(id: id, title: title, image: image, backdrop: backdrop, movie: movie, tvShow: nil, firstAirDate: firstAirDate, lastAirDate: lastAirDate, voteAverage: voteAverage, releaseDate: releaseDate)
                    } else {
                        let tvShow = TVShow(id: id, name: title, overview: "", firstAirDate: firstAirDate ?? "", lastAirDate: lastAirDate ?? "", posterPath: image, backdropPath: backdrop, genres: nil, numberOfSeasons: nil, numberOfEpisodes: nil, seasons: nil, productionCompanies: nil, productionCountries: nil, spokenLanguages: nil, status: nil, voteCount: nil, voteAverage: voteAverage, tagline: nil)
                        return ListItem(id: id, title: title, image: image, backdrop: backdrop, movie: nil, tvShow: tvShow, firstAirDate: firstAirDate, lastAirDate: lastAirDate, voteAverage: voteAverage, releaseDate: nil)
                    }
                } ?? []
                completion(listItems)
            }
        }
    }
    
    func isInList(_ item: ListItem, completion: @escaping (Bool) -> Void) {
        guard let userID = currentUserID else {
            completion(false)
            return
        }
        
        db.collection("users").document(userID).collection("list").document(String(item.id)).getDocument { (document, error) in
            if let document = document, document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
