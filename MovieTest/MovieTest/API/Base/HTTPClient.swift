//
//  HTTPClient.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation
import RxSwift

protocol ClientAPI {
    var httpClient: HTTPClient { get }
}

protocol HTTPClient {
    func send<T: Codable>(request apiRequest: HTTPRequest) -> Single<T>
}

protocol HTTPIdentifier {
    var baseUrl: URL { get }
}

class BaseIdentifier: HTTPIdentifier {
#if DEBUG
    //        var baseUrl = URL(string: "https://newsapi.org/")!
    var baseUrl = URL(string: "https://api.MovieTest.io/")!
#else
    //        var baseUrl = URL(string: "https://newsapi.org/")!
    var baseUrl = URL(string: "https://api.MovieTest.io/")!
#endif
}
