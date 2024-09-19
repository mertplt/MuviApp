//
//  CastDetailViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 05.09.24.
//

import Foundation

class CastDetailsViewModel {
    private let personService: PersonService
    private let apiKey: String
    
    private(set) var castDetails: Person?
    private(set) var movieCredits: UserCredits?
    
    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(personService: PersonService, apiKey: String) {
        self.personService = personService
        self.apiKey = apiKey
    }
    
    func fetchCastDetails(for personId: Int) {
        personService.fetchPersonDetails(for: personId, apiKey: apiKey) { [weak self] result in
            switch result {
            case .success(let person):
                self?.castDetails = person
                self?.fetchMovieCredits(for: personId)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    private func fetchMovieCredits(for personId: Int) {
        personService.fetchPersonCredits(for: personId, apiKey: apiKey) { [weak self] result in
            switch result {
            case .success(let credits):
                self?.movieCredits = credits
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
