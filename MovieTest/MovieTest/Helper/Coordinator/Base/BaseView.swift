//
//  BaseView.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation

protocol BaseView: NSObjectProtocol, Presentable, Bindable { }
protocol Bindable {
    func bindViewModel()
}
