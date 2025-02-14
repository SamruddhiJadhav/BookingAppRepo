//
//  Untitled.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import Foundation

final class BookingsMapper {
    enum MapperError: Error {
        case invalidJsonData
    }
    
    static func map<T: Decodable>(_ data: Data, asType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let model = try? decoder.decode(asType, from: data) else {
            throw MapperError.invalidJsonData
        }
        return model
    }
}
