//
//  BookingNetworkClient.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import BookingService

protocol BookingNetworkClientProtocol {
    func fetchBookings(userId: Int, completion: @escaping (Result<Data, BookingServiceError>) -> Void)
}

final class BookingNetworkClient: BookingNetworkClientProtocol {
    private let apiClient: Network
    
    init(apiClient: Network = Network()) {
        self.apiClient = apiClient
    }
    
    func fetchBookings(userId: Int, completion: @escaping (Result<Data, BookingServiceError>) -> Void) {
        apiClient.fetchBookings(userId: userId) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let apiError):
                completion(.failure(BookingNetworkClient.mapError(apiError)))
            }
        }
    }
    
    private static func mapError(_ error: BookingService.BookingAPIError) -> BookingServiceError {
        switch error {
        case .invalidUserId:
            return .invalidUserId
        case .serverError:
            return .networkFailure
        default:
            return .unknown
        }
    }
}
