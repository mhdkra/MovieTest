//
//  RepositoryModuleFactoryImpl.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation

extension ModuleFactoryImpl: RepositoryModuleFactory {
    func makeMovieListRepo() -> MovieListRepository{
        return MovieListRepositoryImpl(movieListAPI: makeMovieListAPI(), genresAPI: makeGenresAPI())
    }
    
    func makeMovieDetailRepo() -> MovieDetailRepository{
        return MovieDetailRepositoryImpl(movieDetailAPI: makeMovieDetailAPI())
    }
}
