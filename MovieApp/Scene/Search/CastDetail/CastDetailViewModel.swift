//
//  CastDetailViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 05.09.24.
//

import Foundation

class CastDetailsViewModel {
    private let personService: PersonServiceProtocol
    private let personId: Int
    private(set) var castDetails: Person?
    private(set) var movieCredits: UserCredits?

    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(personId: Int, personService: PersonServiceProtocol) {
        self.personId = personId
        self.personService = personService
        fetchCastDetails()
    }

    private func fetchCastDetails() {
        personService.fetchPersonDetails(for: personId) { [weak self] result in
            switch result {
            case .success(let person):
                self?.castDetails = person
                self?.fetchMovieCredits()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }

    private func fetchMovieCredits() {
        personService.fetchPersonCredits(for: personId) { [weak self] result in
            switch result {
            case .success(let credits):
                self?.movieCredits = credits
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }

    func getBirthdayWithAge() -> String {
        guard let birthday = castDetails?.birthday else {
            return "N/A"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let birthDate = dateFormatter.date(from: birthday) else {
            return birthday
        }

        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        let age = ageComponents.year ?? 0

        return "\(birthday) (Age: \(age))"
    }
}
