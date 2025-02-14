//
//  ImageService.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 4/2/25.
//

import UIKit

protocol ImageServiceProtocol {
    func loadImage(
        from url: String,
        toSize: CGSize,
        completion: @escaping (Result<UIImage?, ImageServiceError>) -> Void
    )
    
    func cancelDownload()
}

final class ImageService: ImageServiceProtocol {
    private let client: HTTPClient
    private var currentTask: URLSessionDataTask?

    init(client: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .default))) {
        self.client = client
    }

    func loadImage(
        from url: String,
        toSize: CGSize,
        completion: @escaping (Result<UIImage?, ImageServiceError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        currentTask?.cancel()

        let urlRequest = URLRequest(url: url)
        let task = client.get(from: urlRequest) { result in
            switch result {
            case let .success((data, _)):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(image))
            case .failure:
                completion(.failure(.networkFailure))
            }
            self.currentTask = nil
        }

        currentTask = task
    }
    
    func cancelDownload() {
        currentTask?.cancel()
        currentTask = nil
    }
}
