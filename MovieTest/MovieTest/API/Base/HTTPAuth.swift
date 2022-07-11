//
//  HTTPAuth.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

class HTTPAuth {
    
    static let shared = HTTPAuth()
    private init() { }
    
    var basic: String {
        return ""
    }
    
    var apiKey: String {
        return "a21c065e-0f74-42ac-854c-ea8b22edf6e5"
    }
    
    var bearerToken: String? {
        if let token = Preference.getString(forKey: .AccessTokenKey) {
            return "Bearer \(token)"
        }
        return nil
    }
    
    var refreshToken: String? {
        if let token = Preference.getString(forKey: .AccessRefreshTokenKey) {
            return token
        }
        return nil
    }
    
    var firebaseToken: String? {
        if let token = Preference.getString(forKey: .FirebaseTokenKey) {
            return token
        }
        return nil
    }
    
    func removeAccessToken() {
        Preference.set(value: nil, forKey: .AccessTokenKey)
    }
    
    func removeRefreshToken() {
        Preference.set(value: nil, forKey: .AccessRefreshTokenKey)
    }
    
    func removeFirebaseToken() {
        Preference.set(value: nil, forKey: .FirebaseTokenKey)
    }
    
    func saveBearer(token: String) {
        Preference.set(value: token, forKey: .AccessTokenKey)
    }
    
    func saveRefresh(token: String) {
        Preference.set(value: token, forKey: .AccessRefreshTokenKey)
    }
    
    func saveFirebase(token: String) {
        Preference.set(value: token, forKey: .FirebaseTokenKey)
    }
    
    enum tokenType {
        case basic
        case bearer
    }
    
}
