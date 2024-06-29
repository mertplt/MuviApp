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
            return
        }
        
        guard !password.isEmpty, !confirmPassword.isEmpty else {
            // Handle empty password fields
            return
        }
        
        guard password == confirmPassword else {
            // Handle password mismatch
            return
        }
        
        let registerModel = RegisterModel(email: email, password: password, confirmPassword: confirmPassword)
        
        registerUser(registerModel) { [weak self] success in
            if success {
               
                self?.router.placeOnHomeViewController()
            } else {
               
            }
        }
    }
    
    // Placeholder for registration service call
    private func registerUser(_ model: RegisterModel, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            completion(true)
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
