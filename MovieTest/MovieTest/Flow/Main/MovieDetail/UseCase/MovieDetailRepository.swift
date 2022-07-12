//
//  MovieDetailRepository.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 13/07/22.
//

import Foundation
import RxSwift

protocol MovieDetailRepository {
    func requestDetail(id: Int) -> Single<(MovieDetailModel)>
}
