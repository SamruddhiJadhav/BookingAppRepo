//
//  ImageDownsampler.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 7/2/25.
//

import UIKit

struct ImageDownsampler {
    static func resize(image: UIImage, for size: CGSize) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        format.opaque = false
        format.preferredRange = .standard

        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

