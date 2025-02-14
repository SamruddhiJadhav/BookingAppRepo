//
//  ImageDownloadManager.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 7/2/25.
//

import UIKit

protocol ImageRepository {
    func getImage(
        from url: String,
        toSize: CGSize,
        completion: @escaping (Result<UIImage?, ImageServiceError>) -> Void
    )
    func cancelDownload()
}


final class ImageDownloadManager: ImageRepository {
    private let imageService: ImageServiceProtocol
    
    init(imageService: ImageServiceProtocol) {
        self.imageService = imageService
    }
    
    func getImage(
        from url: String,
        toSize: CGSize,
        completion: @escaping (Result<UIImage?, ImageServiceError>) -> Void
    ) {
        imageService.loadImage(from: url, toSize: toSize) { result in
            switch result {
            case let .success(image):
                if let image = image {
                    let resizedImage = ImageDownsampler.resize(image: image, for: toSize)
                    completion(.success(resizedImage))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelDownload() {
        imageService.cancelDownload()
    }
}
