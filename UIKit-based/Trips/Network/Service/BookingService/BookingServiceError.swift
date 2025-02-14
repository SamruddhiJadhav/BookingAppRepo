//
//  BookingServiceError.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 6/2/25.
//

import Foundation

enum BookingServiceError: Error {
    case invalidUserId
    case networkFailure
    case emptyData
    case unknown
}
