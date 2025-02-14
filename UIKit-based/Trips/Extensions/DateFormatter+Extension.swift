//
//  DateFormatter+Extension.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 5/2/25.
//

import Foundation

extension DateFormatter {
    enum DateFormat: String {
        case day = "d"
        case year = "YYYY"
        case dayMonth = "d MMM"
        case monthYear = "MMM YYYY"
        case dayMonthYear = "d MMM YYYY"
    }
}
