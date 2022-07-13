//
//  GenresAPI.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 13/07/22.
//

import Foundation
import RxSwift

protocol GenresAPI: ClientAPI {
    func request(parameters: [String: Any]) -> Single<GenreResponse>
}
