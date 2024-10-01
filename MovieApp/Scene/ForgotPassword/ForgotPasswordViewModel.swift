//
//  ForgotPasswordViewModel.swift
//  MovieApp
//
//  Created by mert polat on 8.05.2024.
//

import Foundation

class ForgotPasswordViewModel {
    var router: ForgotPasswordRouter
    
    init(router: ForgotPasswordRouter) {
        self.router = router
    }
    
    func resetPassword(email: String?) {
        guard let email = email, !email.isEmpty else {
            return
        }
    }
}
