//
//  MovieListAPI.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import RxSwift

protocol MovieListAPI: ClientAPI {
    func request(parameters: [String: Any]) -> Single<MovieListResponse>
}
