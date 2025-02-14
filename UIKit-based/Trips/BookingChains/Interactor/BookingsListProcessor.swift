//
//  BookingsListProcessor.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

protocol BookingsListProcessorProtocol {
    func chainBookings(of list: BookingList) -> BookingChainList
}

final class BookingsListProcessor: BookingsListProcessorProtocol {
    func chainBookings(of list: BookingList) -> BookingChainList {
        guard let bookings = list.bookings, !bookings.isEmpty else {
            return BookingChainList(upcomingChainList: nil, pastChainList: nil)
        }
        
        // Sorted bookings by the checkin date
        let sortedBookings = bookings.sorted(by: {
            $0.checkin < $1.checkin
        })
        
        var chain = [sortedBookings[0]]
        var i = 1
        var checkoutDate = sortedBookings[0].checkout

        var upcomingChains = [[Booking]]()
        var pastChains = [[Booking]]()
        
        // Matching checkout date (without time) of previous booking with the current booking
        while i < sortedBookings.count {
            if checkoutDate.withoutTime == sortedBookings[i].checkin.withoutTime {
                chain.append(sortedBookings[i])
            } else {
                if checkoutDate.withoutTime > Date().withoutTime {
                    upcomingChains.append(chain)
                } else {
                    pastChains.append(chain)
                }
                chain = [sortedBookings[i]]
            }

            checkoutDate = sortedBookings[i].checkout
            i += 1
        }

        // In a case where chain does not break and bookings are parsed
        if chain.count >= 1 {
            if checkoutDate.withoutTime > Date().withoutTime {
                upcomingChains.append(chain)
            } else {
                pastChains.append(chain)
            }
        }

        upcomingChains = upcomingChains.sorted(by: {
            $0[0].checkout < $1[0].checkout
        })
        
        pastChains = pastChains.sorted(by: {
            $0[0].checkout > $1[0].checkout
        })
        return BookingChainList(upcomingChainList: upcomingChains, pastChainList: pastChains)
    }
}
