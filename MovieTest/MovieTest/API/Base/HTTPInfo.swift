//
//  HTTPInfo.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

extension URL {
    func setParameter(parameters: [String: Any], method: HTTPMethod) -> URLRequest {
        switch method {
        case .GET:
            var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
            var queryItems: [URLQueryItem] = []
            for key in parameters.keys {
                queryItems.append(URLQueryItem(name: key, value: "\(parameters[key]!)"))
            }
            urlComponents.queryItems = queryItems
            urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            return URLRequest(url: urlComponents.url!)
        default:
            var request = URLRequest(url: self)
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            return request
        }
    }
    
    func setParameters(_ parameters: [[String: Any]]) -> URLRequest {
        var request = URLRequest(url: self)
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        return request
    }
}

extension URLRequest {
    mutating func setHeader(type: HeaderType, authType: HTTPAuth.tokenType) {
        switch type {
        case .basic:
            self.setDefaultHeader(type: authType)
        }
    }
    
    mutating func setDefaultHeader(type: HTTPAuth.tokenType) {
        self.setAuthHeader(type: type)
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.addValue("application/json", forHTTPHeaderField: "accept")
    }
}

extension URLRequest {
    private mutating func setAuthHeader(type: HTTPAuth.tokenType) {
        switch type {
        case .basic:
            self.setBasicAuth()
        case .bearer:
            self.setBearerAuth()
        }
    }
    
    private mutating func setBasicAuth() {
//        self.addValue(AMHTTPAuth.shared.basic, forHTTPHeaderField: "Authorization")
        return
    }
    
    private mutating func setBearerAuth() {
        if let bearerToken = HTTPAuth.shared.bearerToken {
            self.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        } else {
            self.addValue("", forHTTPHeaderField: "Authorization")
        }
    }
}

extension Encodable {
    public var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    public var dictionaryWithConvert: [String: Any]? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func converted() -> [[String: Any]] {
        do {
            let data = try JSONEncoder().encode(self)
            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return result as? [[String: Any]] ?? []
        } catch let error {
            print("converted() = \(error.localizedDescription)")
            return []
        }
    }
}
