//
//  DataModuleFactory.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation

protocol DataModuleFactory {
    // MARK: - HTTP Client
    func makeBaseIdentifier() -> HTTPIdentifier
    func makeHTTPClient() -> HTTPClient
    
    // MARK: - API    
    func makeMovieListAPI() -> MovieListAPI
}
