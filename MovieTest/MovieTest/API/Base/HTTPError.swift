//
//  HTTPError.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

enum HTTPError: Error {
    case uncodableIssue
    case connectionLost
    case expired
    case internalError
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .uncodableIssue:
            return "Internal Server Error, Please try again!"
        case .connectionLost:
            return "You must be connected to the internet"
        case .expired:
            return "Session was expired"
        case .internalError:
            return "Internal Server Error, Please try again!"
        case .custom(let content):
            return content
        }
    }
}

extension Error {
    
    var readableError: String {
        if let errorInNetwork = self as? HTTPError {
            return errorInNetwork.localizedDescription
        } else {
            return self.localizedDescription
        }
    }
}
