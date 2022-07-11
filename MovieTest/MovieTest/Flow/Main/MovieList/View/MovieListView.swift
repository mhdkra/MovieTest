//
//  MovieListView.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation

protocol MovieListView: BaseView {
    var viewModel: MovieListVM! { get set }
    var onCardTapped: ((MovieModel) -> Void)? { get set }
}
