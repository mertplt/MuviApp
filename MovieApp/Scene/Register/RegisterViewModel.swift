//
//  RegisterViewModel.swift
//  MovieApp
//
//  Created by mert polat on 2.03.2024.
//

import Foundation

class RegisterViewModel {
    var router: RegisterRouter
    
    init(router: RegisterRouter) {
        self.router = router
    }
    
    func register(email: String, password: String, confirmPassword: String) {
        // Validate email and passwords
        guard isValidEmail(email) else {
            // Handle invalid email case
            // Display an error message to the user
            // e.g., show an alert indicating invalid email format
            print("Invalid email format")
            return
        }
        
        guard !password.isEmpty, !confirmPassword.isEmpty else {
            // Handle empty password fields
            // Display an error message to the user
            // e.g., show an alert indicating empty password fields
            print("Password fields cannot be empty")
            return
        }
        
        guard password == confirmPassword else {
            // Handle password mismatch
            // Display an error message to the user
            // e.g., show an alert indicating password mismatch
            print("Passwords do not match")
            return
        }
        
        // Use Firebase Authentication to register the user
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle error during registration
                // Display an error message to the user based on the error
                // e.g., "Email already exists", "Weak password"
                print("Registration Error: \(error.localizedDescription)")
                // You can display an error message to the user here, e.g., using an alert
            } else {
                // User successfully registered
                print("User successfully registered.")
                
                // Optionally, set user profile data (displayName, etc.) after registration
                //  let user = authResult?.user
                //  user?.updateProfile(withDisplayName: "YourDisplayName") { error in
                //      // Handle any errors updating the profile
                //  }
                
                // Navigate to the Home Screen (or any other desired screen)
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
                
                // Successfully signed in with Google
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
