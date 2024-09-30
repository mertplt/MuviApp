//
//  PersonService.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import Foundation

protocol PersonServiceProtocol {
    func fetchPersonDetails(for personId: Int, completion: @escaping (Result<Person, Error>) -> Void)
    func fetchPersonCredits(for personId: Int, completion: @escaping (Result<UserCredits, Error>) -> Void)
}

class PersonService: PersonServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    private let apiKey: String

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, apiKey: String = Config.shared.apiKey ?? "") {
        self.networkManager = networkManager
        self.apiKey = apiKey
    }

    func fetchPersonDetails(for personId: Int, completion: @escaping (Result<Person, Error>) -> Void) {
        let request = GetPersonDetailsRequest(apiKey: apiKey, personId: personId)
        networkManager.requestWithAlamofire(for: request, result: completion)
    }

    func fetchPersonCredits(for personId: Int, completion: @escaping (Result<UserCredits, Error>) -> Void) {
        let request = GetPersonCreditsRequest(apiKey: apiKey, personId: personId)
        networkManager.requestWithAlamofire(for: request, result: completion)
    }
}
