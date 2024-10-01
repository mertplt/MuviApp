//
//  RegisterViewModel.swift
//  MovieApp
//
//  Created by mert polat on 2.03.2024.
//

import Foundation
import FirebaseAuth
import UIKit
import GoogleSignIn
import FirebaseCore

class RegisterViewModel {
    var router: RegisterRouter
    
    init(router: RegisterRouter) {
        self.router = router
    }
    
    func register(email: String, password: String, confirmPassword: String) {
        guard isValidEmail(email) else {
            print("Invalid email format")
            return
        }
        
        guard !password.isEmpty, !confirmPassword.isEmpty else {
            print("Password fields cannot be empty")
            return
        }
        
        guard password == confirmPassword else {
            print("Passwords do not match")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                
                print("Registration Error: \(error.localizedDescription)")
            } else {
                print("User successfully registered.")
                
                self.router.pushTabBarViewController()
            }
        }
    }
    
    func signInWithGoogle(presenting viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] result, error in
            guard error == nil else {
                print("Google Sign-In Error: \(error!.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Failed to get ID token from Google Sign-In")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign-in error: \(error.localizedDescription)")
                    return
                }
                print("User successfully signed in with Google.")
                self?.router.pushTabBarViewController()
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
