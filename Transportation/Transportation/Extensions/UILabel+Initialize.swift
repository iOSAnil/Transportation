//
//  UILabel+Initialize.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont) {
        self.init(autoLayout: true)
        self.font = font
    }
    
    func transformToPillShape() {
        self.textColor = .black
        self.numberOfLines = 1
        self.backgroundColor = #colorLiteral(red: 0.8565761447, green: 0.8565762639, blue: 0.8565761447, alpha: 1)
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
