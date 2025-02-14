//
//  Untitled.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 4/2/25.
//

import Foundation

protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func get(from urlRequest: URLRequest, completion: @escaping(Result) -> Void) -> URLSessionDataTask
}

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private struct UnexpectedValuesRepresentation: Error {}
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
        return task
    }
}
