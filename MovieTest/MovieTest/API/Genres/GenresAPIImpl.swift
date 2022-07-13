//
//  GenresAPIImpl.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 13/07/22.
//

import Foundation
import RxSwift

class GenresAPIImpl: GenresAPI {
    
    private class GetGenres: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/genre/movie/list"
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
    
    func request(parameters: [String: Any]) -> Single<GenreResponse> {
        return httpClient.send(request: GetGenres(parameters: parameters))
    }
}
