//
//  GenreResponse.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 13/07/22.
//

import Foundation

struct GenreResponse: Codable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
