//
//  Config.swift
//  MovieApp
//
//  Created by Mert Polat on 11.07.2024.
//

import Foundation

class Config {
    static let shared = Config()
    
    var apiKey: String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
           let apiKey = config["API_KEY"] as? String {
            return apiKey
        }
        return nil
    }
}
