//
//  TripCardViewModel.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

struct TripCardViewModel: Hashable {
    let id = UUID()
    let tripLabel: String
    let tripDuration: String
    let numberOfBookingLabel: String
    let imageUrl: String?
}
