//
//  VMModuleFactoryImpl.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

extension ModuleFactoryImpl: VMModuleFactory {
    func makeMovieListVM() -> MovieListVM {
        return MovieListVM(repository: makeMovieListRepo())
    }
    
    func makeMovieDetailVM() -> MovieDetailVM {
        return MovieDetailVM(repository: makeMovieDetailRepo())
    }
    
}
