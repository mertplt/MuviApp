//
//  FirebaseService.swift
//  MovieApp
//
//  Created by Mert Polat on 31.08.24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class FirebaseService {
    static let shared = FirebaseService()
    private init() {}
    
    func updateUserProfile(name: String, email: String, phone: String, image: UIImage?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        var userData: [String: Any] = [
            "name": name,
            "phone": phone,
            "email": email
        ]
        
        let updateFirestoreAndImage = { [weak self] in
            if let image = image {
                self?.uploadImage(image) { result in
                    switch result {
                    case .success(let url):
                        userData["profileImageURL"] = url
                        self?.updateFirestore(userRef: userRef, userData: userData) { firestoreResult in
                            switch firestoreResult {
                            case .success:
                                completion(.success("Profile updated successfully."))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                self?.updateFirestore(userRef: userRef, userData: userData) { firestoreResult in
                    switch firestoreResult {
                    case .success:
                        completion(.success("Profile updated successfully."))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        
        // Check if email is being changed
        if email != user.email {
            // Send verification email to the new address
            user.sendEmailVerification(beforeUpdatingEmail: email) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    // Email verification sent successfully
                    updateFirestoreAndImage()
                    completion(.success("Profile updated. Please verify the new email address sent to \(email) before the email change can take effect."))
                }
            }
        } else {
            // If email is not being changed, proceed with other updates
            updateFirestoreAndImage()
        }
    }
    
    private func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        let storageRef = Storage.storage().reference().child("profile_images").child(UUID().uuidString + ".jpg")
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }
    
    private func updateFirestore(userRef: DocumentReference, userData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        userRef.setData(userData, merge: true) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                if let data = document.data(),
                   let name = data["name"] as? String,
                   let email = data["email"] as? String,
                   let phone = data["phone"] as? String {
                    let profileImageURL = data["profileImageURL"] as? String
                    let userProfile = UserProfile(name: name, email: email, phone: phone, profileImageURL: profileImageURL)
                    completion(.success(userProfile))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid user data"])))
                }
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User document does not exist"])))
            }
        }
    }
}
