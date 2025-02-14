//
//  DownloadableImageView.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 4/2/25.
//

import UIKit

final class DownloadableImageView: UIImageView {
    private let imageDownloadManager: ImageRepository

    init(imageService: ImageServiceProtocol) {
        self.imageDownloadManager = ImageDownloadManager(imageService: imageService)
        super.init(frame: .zero)
    }
    
    convenience init() {
        let imageService = ImageService()
        self.init(imageService: imageService)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func image(
      for imageUrl: String,
      contentMode: ContentMode? = nil,
      placeholder: UIImage? = UIImage(named: "placeholder"),
      size: CGSize,
      completion: (() -> Void)? = nil
    ) {
        clipsToBounds = true
        self.contentMode = .center
        placeholderFallback(placeholder)

        imageDownloadManager.getImage(from: imageUrl, toSize: size) { [weak self] result in
            switch result {
            case let .success(image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure:
                print("Image download failed.")
            }
        }
     }
    
    func cancelDownload() {
        imageDownloadManager.cancelDownload()
    }
}

private extension DownloadableImageView {
    func placeholderFallback(_ placeholder: UIImage?) {
        contentMode = .center
        image = placeholder
    }
}
