//
//  Booking.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

struct Booking: Decodable {
    let checkin: Date
    let id: Double
    let booker: Booker
    let checkout: Date
    let hotel: Hotel
}
