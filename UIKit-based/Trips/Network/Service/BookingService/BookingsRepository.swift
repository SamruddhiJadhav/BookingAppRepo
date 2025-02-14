//
//  BookingsRepository.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

protocol BookingsRepositoryProtocol {
    func fetchBookings(
        userId: Int,
        completion: @escaping (Result<Data, BookingServiceError>) -> Void
    )
}

final class BookingsRepository: BookingsRepositoryProtocol {
    private let apiClient: BookingNetworkClientProtocol
    
    init(apiClient: BookingNetworkClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchBookings(
        userId: Int,
        completion: @escaping (Result<Data, BookingServiceError>) -> Void
    ) {
        apiClient.fetchBookings(userId: userId, completion: completion)
    }
}
