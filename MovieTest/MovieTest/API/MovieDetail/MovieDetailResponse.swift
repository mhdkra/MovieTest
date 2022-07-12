//
//  MovieDetailResponse.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
// MARK: - MovieResponse
struct MovieDetailResponse: Codable {
    
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath, name, originCountry: String?
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?
}
