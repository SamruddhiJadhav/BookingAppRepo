//
//  BookingSection.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 7/2/25.
//

import Foundation

enum BookingSection: Hashable {
    case upcoming
    case past

    var title: String {
        switch self {
        case .upcoming: return "Upcoming trips"
        case .past: return "Past trips"
        }
    }
}

