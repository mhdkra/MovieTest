//
//  RepositoryModuleFactoryImpl.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation

extension ModuleFactoryImpl: RepositoryModuleFactory {
    func makeMovieListRepo() -> MovieListRepository{
        return MovieListRepositoryImpl(cardsAPI: makeCardsAPI())
    }
    
    func makeMovieDetailRepo() -> MovieDetailRepository{
        return MovieDetailRepositoryImpl(cardsAPI: makeCardsAPI())
    }
}
