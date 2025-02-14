//
//  BookingsService.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

protocol BookingsServiceProtocol {
    func fetchBookings(
        userId: Int,
        completion: @escaping (Result<BookingList, BookingServiceError>) -> Void
    )
}

final class BookingsService: BookingsServiceProtocol {
    private let repository: BookingsRepositoryProtocol
    
    init(repository: BookingsRepositoryProtocol) {
        self.repository = repository
    }

    func fetchBookings(userId: Int, completion: @escaping (Result<BookingList, BookingServiceError>) -> Void) {
        repository.fetchBookings(userId: userId) { result in
            switch result {
            case let .success(data):
                completion(BookingsService.map(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private static func map(_ data: Data) -> Result<BookingList, BookingServiceError> {
        do {
            let bookingsList = try BookingsMapper.map(data, asType: BookingList.self)
            if bookingsList.bookings?.isEmpty == true {
                return .failure(.emptyData)
            }
            return .success(bookingsList)
        } catch {
            return .failure(.invalidUserId)
        }
    }
}
