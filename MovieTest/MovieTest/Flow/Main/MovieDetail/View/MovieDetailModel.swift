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
    let title: String
    let movieImage: String
    let duration: String
    let genres: [String]
    let overview: String
}

struct CastModel{
    let name: String
    let imageUrl: String
}
