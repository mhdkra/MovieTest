//
//  MovieListResponse.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation

// MARK: - MovieResponse
struct MovieListResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}

enum BasicUIState {
    case close
    case loading
    case success(String)
    case failure(String)
    case warning(String)
    case stopLoadMore
    case stopRefresh
}
