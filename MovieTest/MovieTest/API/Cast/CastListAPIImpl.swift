//
//  CastListAPImpl.swift
//  MovieTest
//
//  Created by Tiara Mahardika on 13/07/22.
//

import Foundation
import RxSwift

class CastListAPIImpl: CastListAPI {
    
    private class GetDetailCase: HTTPRequest {
        var method = HTTPMethod.GET
        var path = ""
        var apiVersion = ApiVersion.v3
        var parameters: [String: Any] = [String: Any]()
        var authentication = HTTPAuth.tokenType.basic
        var header = HeaderType.basic
        
        init(id: Int) {
            self.path = "/movie/\(id)/credits"
            self.parameters = BaseBody(api_key: HTTPAuth.shared.apiKey).dictionary ?? [String:Any]()
        }
    }
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func request(id: Int) -> Single<CastListResponse> {
        return httpClient.send(request: GetDetailCase(id: id))
    }
}
