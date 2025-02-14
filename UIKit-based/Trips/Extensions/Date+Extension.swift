//
//  Date+Extension.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 4/2/25.
//

import Foundation

extension Date {
    func isSame(_ component: Calendar.Component, as date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func formatted(_ dateFormat: DateFormatter.DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.string(from: self)
    }
    
    var withoutTime: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
