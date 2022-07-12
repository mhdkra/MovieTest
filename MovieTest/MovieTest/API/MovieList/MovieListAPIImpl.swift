//
//  MovieListAPIImpl.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import RxSwift

class MovieListAPIImpl: MovieListAPI {
    
    private class GetMovies: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/search/movie"
        var apiVersion = ApiVersion.v3
        var parameters: [String: Any]
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(parameters: [String: Any]) {
            self.parameters = parameters
        }
    }
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func request(parameters: [String: Any]) -> Single<MovieListResponse> {
        return httpClient.send(request: GetMovies(parameters: parameters))
    }
}
