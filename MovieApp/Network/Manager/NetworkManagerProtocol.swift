//
//  NetworkManagerProtocol.swift
//  MovieApp
//
//  Created by Mert Polat on 10.07.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func requestWithAlamofire<T: RequestProtocol>(for request: T, result: @escaping (Result<T.ResponseType, Error>) -> Void)
}
