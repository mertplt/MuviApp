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
    
    enum SortOption: String, CaseIterable {
        case addedNewToOld = "Added (New to Old)"
        case addedOldToNew = "Added (Old to New)"
        case ratingHighToLow = "Rating (High to Low)"
        case ratingLowToHigh = "Rating (Low to High)"
        case dateNewToOld = "Date (New to Old)"
        case dateOldToNew = "Date (Old to New)"
    }
    var currentSortOption: SortOption = .addedNewToOld

    private init() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.currentUserID = user?.uid
        }
    } 
    
    func addToList(_ item: ListItem) {
        guard let userID = currentUserID else { return }
        
        let timestamp = FieldValue.serverTimestamp()
        
        db.collection("users").document(userID).collection("list").document(String(item.id)).setData([
            "id": item.id,
            "title": item.title,
            "image": item.image,
            "vote_average": item.voteAverage ?? 0,
            "first_air_date": item.firstAirDate ?? "",
            "last_air_date": item.lastAirDate ?? "",
            "release_date": item.releaseDate ?? "",
            "backdrop": item.backdrop ?? "",
            "isMovie": item.movie != nil,
            "added_date": timestamp
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
           
           db.collection("users").document(userID).collection("list").getDocuments { [weak self] (querySnapshot, error) in
               guard let self = self else { return }
               if let error = error {
                   print("Error getting documents: \(error)")
                   completion([])
               } else {
                   var listItems = querySnapshot?.documents.compactMap { document -> ListItem? in
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
                       let addedDate = data["added_date"] as? Timestamp
                       
                       if isMovie {
                           let movie = Movie(id: id, title: title, overview: "", releaseDate: releaseDate ?? "", posterPath: image, backdropPath: backdrop, mediaType: nil, originalName: nil, originalTitle: nil, voteCount: nil, voteAverage: voteAverage, genres: nil, runtime: nil, productionCompanies: nil, productionCountries: nil, spokenLanguages: nil, status: nil, tagline: nil)
                           return ListItem(id: id, title: title, image: image, backdrop: backdrop, movie: movie, tvShow: nil, firstAirDate: firstAirDate, lastAirDate: lastAirDate, voteAverage: voteAverage, releaseDate: releaseDate, addedDate: addedDate?.dateValue())
                       } else {
                           let tvShow = TVShow(id: id, name: title, overview: "", firstAirDate: firstAirDate ?? "", lastAirDate: lastAirDate ?? "", posterPath: image, backdropPath: backdrop, genres: nil, numberOfSeasons: nil, numberOfEpisodes: nil, seasons: nil, productionCompanies: nil, productionCountries: nil, spokenLanguages: nil, status: nil, voteCount: nil, voteAverage: voteAverage, tagline: nil)
                           return ListItem(id: id, title: title, image: image, backdrop: backdrop, movie: nil, tvShow: tvShow, firstAirDate: firstAirDate, lastAirDate: lastAirDate, voteAverage: voteAverage, releaseDate: nil, addedDate: addedDate?.dateValue())
                       }
                   } ?? []
                   self.sortListItems(&listItems)
                completion(listItems)
            }
        }
    }
    
    private func sortListItems(_ items: inout [ListItem]) {
        switch currentSortOption {
        case .dateNewToOld:
            items.sort { (item1, item2) -> Bool in
                let date1 = self.getDate(for: item1)
                let date2 = self.getDate(for: item2)
                return date1 > date2
            }
        case .dateOldToNew:
            items.sort { (item1, item2) -> Bool in
                let date1 = self.getDate(for: item1)
                let date2 = self.getDate(for: item2)
                return date1 < date2
            }
        case .ratingHighToLow:
            items.sort { (item1, item2) -> Bool in
                return (item1.voteAverage ?? 0) > (item2.voteAverage ?? 0)
            }
        case .ratingLowToHigh:
            items.sort { (item1, item2) -> Bool in
                return (item1.voteAverage ?? 0) < (item2.voteAverage ?? 0)
            }
        case .addedNewToOld:
            items.sort { (item1, item2) -> Bool in
                return (item1.addedDate ?? Date.distantPast) > (item2.addedDate ?? Date.distantPast)
            }
        case .addedOldToNew:
            items.sort { (item1, item2) -> Bool in
                return (item1.addedDate ?? Date.distantPast) < (item2.addedDate ?? Date.distantPast)
            }
        }
    }

    private func getDate(for item: ListItem) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let movie = item.movie, let releaseDate = movie.releaseDate {
            return dateFormatter.date(from: releaseDate) ?? Date.distantPast
        } else if let tvShow = item.tvShow, let firstAirDate = tvShow.firstAirDate {
            return dateFormatter.date(from: firstAirDate) ?? Date.distantPast
        }
        
        return Date.distantPast
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
