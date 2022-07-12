//
//  MovieListBody.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
struct MovieListBody: Codable {
    var apiKey: String = HTTPAuth.shared.apiKey
    let query : String?
    let page: Int?

}
