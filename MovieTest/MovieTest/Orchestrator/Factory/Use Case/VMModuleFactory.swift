//
//  VMModuleFactory.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22
//

import Foundation

protocol VMModuleFactory {
    // MARK: - Main

    func makeMovieListVM() -> MovieListVM
    func makeMovieDetailVM() -> MovieDetailVM 
}
