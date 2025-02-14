//
//  ErrorViewModel.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 6/2/25.
//

import Foundation

struct ErrorViewModel {
    let errorTitle: String
    let errorMessage: String
    let action: String
    
    init(errorTitle: String, errorMessage: String, action: String = "OK") {
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.action = action
    }
}
