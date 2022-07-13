//
//  HTTPRequest.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

enum ApiVersion: String {
    case v1 = "v1"
    case v2 = "v2"
    case v3 = "3"
    case none = ""
}

enum HeaderType {
    case basic
}

protocol HTTPRequest {
    var method: HTTPMethod { get set }
    var path: String { get }
    var parameters: [String: Any] { get }
    var apiVersion: ApiVersion { get set }
    var authentication: HTTPAuth.tokenType { get  set }
    var header: HeaderType { get set }
}

protocol HTTPBackupRequest {
    var method: HTTPMethod { get set }
    var path: String { get }
    var parameters: [[String: Any]] { get }
    var apiVersion: ApiVersion { get set }
    var authentication: HTTPAuth.tokenType { get  set }
    var header: HeaderType { get set }
}

extension HTTPRequest {
    func request(with baseUrl: URL) -> URLRequest {
        let url = "\(baseUrl.absoluteString)/\(self.apiVersion.rawValue)\(self.path)"
        let finalUrl = URL(string: url)!
        
        var request = finalUrl.setParameter(parameters: parameters, method: method)
        request.setHeader(type: self.header, authType: self.authentication)
        request.httpMethod = self.method.rawValue
        print("\n=====HTTPRequest=====")
        print("HEADER = \(String(describing: request.allHTTPHeaderFields))")
        if let body = request.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    print("BODY = \(json)")
                }
            } catch let error {
                print(error)
            }
        }
        print("URL = \(String(describing: request.url?.absoluteString))")
        print("METHOD = \(request.httpMethod ?? "NONE")")
        print("====================\n")
        return request
    }
}

extension HTTPBackupRequest {
    func request(with baseUrl: URL) -> URLRequest {
        let url = "\(baseUrl.absoluteString)\(self.apiVersion.rawValue)\(self.path)"
        let finalUrl = URL(string: url)!
        
        var request = finalUrl.setParameters(parameters)
        request.setHeader(type: self.header, authType: self.authentication)
        request.httpMethod = self.method.rawValue
        print("\n=====HTTPRequest=====")
        print("HEADER = \(String(describing: request.allHTTPHeaderFields))")
        if let body = request.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    print("BODY = \(json)")
                }
            } catch let error {
                print(error)
            }
        }
        print("URL = \(String(describing: request.url?.absoluteString))")
        print("METHOD = \(request.httpMethod ?? "NONE")")
        print("====================\n")
        return request
    }
}
