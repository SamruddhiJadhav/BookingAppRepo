//
//  BookingChainDataSourceBuilder.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 4/2/25.
//

import Foundation

protocol BookingChainDataSourceBuilderProtocol {
    func bookingsSection(_ chainList: BookingChainList) -> [BookingsSection]
    func errorViewModel(_ error: BookingServiceError) -> ErrorViewModel
}

final class BookingChainDataSourceBuilder: BookingChainDataSourceBuilderProtocol {
    func bookingsSection(_ chainList: BookingChainList) -> [BookingsSection] {
        var sections = [BookingsSection]()
        if let upcomingChainList = chainList.upcomingChainList, !upcomingChainList.isEmpty {
            let upcomingTripCards = trips(upcomingChainList)
            if upcomingTripCards.count > 0 {
                sections.append(
                    BookingsSection(bookingType: .upcoming, tripCards: upcomingTripCards)
                )
            }
        }
        
        if let pastChainList = chainList.pastChainList, !pastChainList.isEmpty {
            let pastTripCards = trips(pastChainList)
            if pastTripCards.count > 0 {
                sections.append(
                    BookingsSection(bookingType: .past, tripCards: pastTripCards)
                )
            }
        }
        
        return sections
    }
    
    func errorViewModel(_ error: BookingServiceError) -> ErrorViewModel {
        switch error {
        case .invalidUserId, .unknown:
            return ErrorViewModel(errorTitle: "Oops!", errorMessage: "Something went wrong. Please try again later.")
        case .networkFailure:
            return ErrorViewModel(errorTitle: "Netwrok Failure!", errorMessage: "Please check your internet and try again.")
        case .emptyData:
            return ErrorViewModel(errorTitle: "Sorry!", errorMessage: "We could not load the data.")
        }
    }
}

private extension BookingChainDataSourceBuilder {
    func trips(_ chainList: [[Booking]]) -> [TripCardViewModel] {
        var tripCards = [TripCardViewModel]()
        for chain in chainList {
            if !chain.isEmpty {
                let cities = cities(chain)
                let viewModel = TripCardViewModel(
                    tripLabel: tripLabel(cities),
                    tripDuration: tripDuration(chain),
                    numberOfBookingLabel: numberOfBookingLabel(chain),
                    imageUrl: chain.first?.hotel.heroImageUrl
                )
                tripCards.append(viewModel)
            }
        }
        return tripCards
    }

    func cities(_ chain: [Booking]) -> [String] {
        var cities = [String]()

        for i in 0..<chain.count {
            if cities.last != chain[i].hotel.cityName {
                cities.append(chain[i].hotel.cityName)
            }
        }
        
        return cities
    }

    func tripLabel(_ cities: [String]) -> String {
        var citiesLabel = "Trip to \(cities[0])"
        var i = 1
        
        while i < cities.count - 1 {
            citiesLabel += ", \(cities[i])"
            i += 1
        }
        
        if cities.count > 1 {
            citiesLabel += " and \(cities[i])"
        }
        
        return citiesLabel
    }

    func tripDuration(_ chain: [Booking]) -> String {
        guard let checkin = chain.first?.checkin, let checkout = chain.last?.checkout else {
            return ""
        }

        if checkin.isSame(.year, as: checkout) {
            if checkin.isSame(.month, as: checkout) {
                return "\(checkin.formatted(.day))-\(checkout.formatted(.day)) \(checkout.formatted(.monthYear))"
            }
            return "\(checkin.formatted(.dayMonth))-\(checkout.formatted(.dayMonth)) \(checkin.formatted(.year))"
        }
        
        return "\(checkin.formatted(.dayMonthYear)) - \(checkout.formatted(.dayMonthYear))"
    }
    
    func numberOfBookingLabel(_ chain: [Booking]) -> String {
        let bookingString = chain.count > 1 ? "Bookings" : "Booking"
        return "\(chain.count) \(bookingString)"
    }
}
