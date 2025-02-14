//
//  LoadingIndicatorView.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 4/2/25.
//

import UIKit

final class LoadingIndicatorView: UIView {
    private let viewFrame: CGRect

    private lazy var loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        self.viewFrame = frame
        super.init(frame: frame)
        setupLoadingIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        isHidden = false
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        isHidden = true
    }
}

private extension LoadingIndicatorView {
    func setupLoadingIndicator() {
        frame = viewFrame
        backgroundColor = .white
        isHidden = true
            
        setupSpinner()
    }
      
    func setupSpinner() {
        loadingIndicator.center = CGPoint(
            x: UIScreen.main.bounds.size.width / 2,
            y: UIScreen.main.bounds.size.height / 2
        )
        loadingIndicator.hidesWhenStopped = true
        addSubview(loadingIndicator)
    }
}
