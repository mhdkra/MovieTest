//
//  RepositoryModuleFactory.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation

protocol RepositoryModuleFactory {
    // MARK: - Main
    func makeMovieListRepo() -> MovieListRepository
    func makeMovieDetailRepo() -> MovieDetailRepository

}
