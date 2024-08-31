//
//  EditProfileViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 31.08.24.
//

import Foundation
import UIKit
import FirebaseAuth

class EditProfileViewModel {
    var userProfile: UserProfile?
    
    func updateProfile(name: String, email: String, phone: String, image: UIImage?, completion: @escaping (Result<String, Error>) -> Void) {
        FirebaseService.shared.updateUserProfile(name: name, email: email, phone: phone, image: image) { result in
            switch result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
