//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by mert polat on 1.03.2024.
//

import Foundation

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
        
        // Create LoginModel
        let loginModel = LoginModel(email: email, password: password)
        
        loginUser(loginModel) { [weak self] success in
            if success {
                self?.router.placeOnHomeViewController()
            } else {
            }
        }
    }
    
    private func loginUser(_ model: LoginModel, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            completion(true)
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
