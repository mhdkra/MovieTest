//
//  MovieDetailModel.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import UIKit

struct MovieDetailModel {
    let movieImage: UIImage
    let duration: String
    let genres: String
    let cast: [CastModel]
}

struct CastModel{
    let name: String
    let image: UIImage
}
