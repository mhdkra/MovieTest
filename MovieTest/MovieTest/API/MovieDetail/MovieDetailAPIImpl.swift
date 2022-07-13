//
//  MovieDetailAPIImpl.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 12/07/22.
//

import Foundation
import RxSwift

class MovieDetailAPIImpl: MovieDetailAPI {
    
    private class GetDetailMovie: HTTPRequest {
        var method = HTTPMethod.GET
        var path = "/movie/"
        var apiVersion = ApiVersion.v3
        var parameters: [String: Any] = [String: Any]()
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(id: Int) {
            self.path = "/movie/\(id)"
            self.parameters = BaseBody(api_key: HTTPAuth.shared.apiKey).dictionary ?? [String:Any]()
        }
    }
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func request(id: Int) -> Single<MovieDetailResponse>{
        return httpClient.send(request: GetDetailMovie(id: id))
    }
}
