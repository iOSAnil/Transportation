//
//  ActivityIndicatorView.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit
import Foundation

final class ActivityIndicatorView: UIView {
    private static let width: CGFloat = 40
    private static let height: CGFloat = 40
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.autoLayout()
        view.style = .large
        view.color = .gray
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateUI() {
        addSubview(activityView)
            
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityView.widthAnchor.constraint(equalToConstant: ActivityIndicatorView.width),
            activityView.heightAnchor.constraint(equalToConstant: ActivityIndicatorView.height)
        ])
    }
}
