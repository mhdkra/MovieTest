//
//  BaseBody.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 13/07/22.
//

import Foundation
struct BaseBody: Codable {
    var api_key: String = HTTPAuth.shared.apiKey
}
