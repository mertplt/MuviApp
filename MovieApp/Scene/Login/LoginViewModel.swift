//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by mert polat on 1.03.2024.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase
import FirebaseCore

class LoginViewModel {
    var router: LoginRouter
    
    init(router: LoginRouter) {
        self.router = router
    }
    
    func login(email: String, password: String) {
        guard isValidEmail(email) else {
            // Handle invalid email case
            return
        }
        
        guard !password.isEmpty else {
            // Handle empty password case
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // Handle the error
                print("Login Error: \(error.localizedDescription)")
                // You can display an error message to the user here
            } else {
                // Successfully logged in
                print("User successfully logged in.")
                self?.router.pushTabBarViewController()
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
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
