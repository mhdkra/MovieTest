//
//  MainFactory.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

protocol MainFactory {
    func makeMovieListView() -> MovieListView
    func makeMovieDetailView() -> MovieDetailView
}
