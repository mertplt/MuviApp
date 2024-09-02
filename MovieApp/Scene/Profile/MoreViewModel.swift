//
//  MoreViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 31.08.24.
//

import Foundation
import UIKit

class MoreViewModel {
    var userProfile: UserProfile?
    
    func fetchUserProfile(completion: @escaping (Result<Void, Error>) -> Void) {
        FirebaseService.shared.fetchUserProfile { [weak self] result in
            switch result {
            case .success(let userProfile):
                self?.userProfile = userProfile
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
