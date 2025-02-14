//
//  BookingChainBuilder.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import UIKit

final class BookingChainBuilder {
    static func build() -> UIViewController {
        let view = BookingChainViewController()
        let client = BookingNetworkClient()
        let repository = BookingsRepository(apiClient: client)

        let bookingService = BookingsService(repository: repository)
        
        let processor = BookingsListProcessor()
        let interactor = BookingChainInteractor(
            bookingService: bookingService,
            bookingListProcessor: processor
        )
        
        let datasourceBuilder = BookingChainDataSourceBuilder()
        let presenter = BookingChainPresenter(
            view: view,
            interactor: interactor,
            datasourceBuilder: datasourceBuilder
        )
        
        view.presenter = presenter
        
        return view
    }
}
