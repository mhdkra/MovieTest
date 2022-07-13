//
//  MainFactoryImpl.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

extension ModuleFactoryImpl: MainFactory {
    func makeMovieListView() -> MovieListView {
        let vc = MovieListVC()
        vc.viewModel = makeMovieListVM()
        return vc
    }
    
    func makeMovieDetailView() -> MovieDetailView {
        let vc = MovieDetailVC()
        vc.viewModel = makeMovieDetailVM()
        return vc
    }
    
}
