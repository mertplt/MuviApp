//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by mert polat on 1.03.2024.
//

import UIKit

class LoginViewModel {
//    var loginStatus: Observable<String> = Observable("")
    
    func login(loginModel: LoginModel) {
        // Giriş verilerini doğrulama ve giriş işlemini gerçekleştirme kodları
        if loginModel.email.isEmpty || loginModel.password.isEmpty {
//            loginStatus.value = "Username or password cannot be empty"
            return
        }
        
//        loginStatus.value = "Logging in..."
        
        // Sunucu ile giriş işlemini gerçekleştirme kodları
        // Bu örnekte basitçe başarılı olduğunu varsayalım
        let success = true
        
        if success {
//            loginStatus.value = "Login successful"
            // Router ile ana sayfaya yönlendirme kodları
//            LoginRouter.navigateToRegister()
        } else {
//            loginStatus.value = "Login failed"
        }
    }
}