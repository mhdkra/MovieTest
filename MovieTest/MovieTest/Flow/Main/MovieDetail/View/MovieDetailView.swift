//
//  MovieDetailView.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation

protocol MovieDetailView: BaseView {
    var viewModel: MovieDetailVM! { get set }
    var onCardTapped: ((MovieModel) -> Void)? { get set }
}
