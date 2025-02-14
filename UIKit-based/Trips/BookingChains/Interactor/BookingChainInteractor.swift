//
//  BookingChainInteractor.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

protocol BookingChainInteractorProtocol {
    func fetchBookings(
        userId: Int,
        completion: @escaping (BookingChainList) -> Void,
        onError: @escaping (_ errorMessage: BookingServiceError) -> Void
    )
}

final class BookingChainInteractor: BookingChainInteractorProtocol {
    private let bookingService: BookingsServiceProtocol
    private let bookingListProcessor: BookingsListProcessorProtocol
    
    init(
        bookingService: BookingsServiceProtocol,
        bookingListProcessor: BookingsListProcessorProtocol
    ) {
        self.bookingService = bookingService
        self.bookingListProcessor = bookingListProcessor
    }

    func fetchBookings(
        userId: Int,
        completion: @escaping (BookingChainList) -> Void,
        onError: @escaping (BookingServiceError) -> Void
    ) {
        bookingService.fetchBookings(userId: userId) { [weak self] result in
            switch result {
            case let .success(list):
                guard let self = self else {
                    return
                }
                let chainList = self.bookingListProcessor.chainBookings(of: list)
                completion(chainList)
            case let .failure(error):
                onError(error)
            }
        }
    }
}
