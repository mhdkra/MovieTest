//
//  CastListAPI.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 13/07/22.
//

import Foundation
import RxSwift

protocol CastListAPI: ClientAPI {
    func request(id: Int) -> Single<CastListResponse>
}
