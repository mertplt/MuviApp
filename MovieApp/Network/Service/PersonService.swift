//
//  PersonService.swift
//  MovieApp
//
//  Created by Mert Polat on 03.09.24.
//

import Foundation

protocol PersonServiceProtocol {
    func fetchPersonDetails(for personId: Int, apiKey: String, completion: @escaping (Result<Person, Error>) -> Void)
}

class PersonService: PersonServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchPersonDetails(for personId: Int, apiKey: String, completion: @escaping (Result<Person, Error>) -> Void) {
        let request = GetPersonDetailsRequest(apiKey: apiKey, personId: personId)
        networkManager.requestWithAlamofire(for: request) { (result: Result<Person, Error>) in
            switch result {
            case .success(let person):
                completion(.success(person))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPersonCredits(for personId: Int, apiKey: String, completion: @escaping (Result<UserCredits, Error>) -> Void) {
        let request = GetPersonCreditsRequest(apiKey: apiKey, personId: personId)
        networkManager.requestWithAlamofire(for: request) { (result: Result<UserCredits, Error>) in
            switch result {
            case .success(let credits):
                completion(.success(credits))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

