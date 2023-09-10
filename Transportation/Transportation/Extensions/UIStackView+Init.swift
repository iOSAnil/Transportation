//
//  UIStackView+Init.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit

extension UIStackView {
    convenience init(distribution: UIStackView.Distribution,
                     alignment: UIStackView.Alignment,
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     isAutoResizingEnabled: Bool = false) {
        self.init(autoLayout: true)
        self.distribution = distribution
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
    }
    
    func addArrangedSubviews( _ subViews: UIView...) {
        subViews.forEach({addArrangedSubview($0)})
    }
    
    func removeAllArrangedSubviews() {
        let subviews = self.arrangedSubviews
        subviews.forEach({removeArrangedSubview($0)})
        subviews.forEach({$0.removeFromSuperview()})
    }
}
