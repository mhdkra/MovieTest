//
//  ScheduleProvider.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22  .
//

import Foundation
import RxSwift

class ScheduleProvider {
    
    static let shared: ScheduleProvider = ScheduleProvider()
    
    public let main = MainScheduler.instance
    public let background = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)
}
