//
//  BaseViewModel.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
