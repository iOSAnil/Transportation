//
//  UIButton+Initialize.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit

extension UIButton {
    convenience init(font: UIFont) {
        self.init(autoLayout: true)
        self.titleLabel?.font = font
    }
}
