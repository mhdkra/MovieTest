//
//  MovieDetailModel.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import UIKit

struct MovieDetailModel {
    let id: Int
    let movieImage: URL
    let duration: String
    let genres: [String]
    let overview: String
//    let cast: [CastModel]
}

struct CastModel{
    let name: String
    let image: UIImage
}
