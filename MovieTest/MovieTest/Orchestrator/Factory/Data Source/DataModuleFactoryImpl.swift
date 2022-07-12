//
//  DataModuleFactoryImpl.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import Foundation

class ModuleFactoryImpl: DataModuleFactory {
    
    func makeBaseIdentifier() -> HTTPIdentifier {
        return BaseIdentifier()
    }
    
    func makeHTTPClient() -> HTTPClient {
        return HTTPClientImpl(identifier: makeBaseIdentifier())
    }

    func makeMovieListAPI() -> MovieListAPI{
        MovieListAPIImpl(httpClient: makeHTTPClient())
    }
    
    func makeMovieDetailAPI() -> MovieDetailAPI{
        MovieDetailAPIImpl(httpClient: makeHTTPClient())
    }
    
}
