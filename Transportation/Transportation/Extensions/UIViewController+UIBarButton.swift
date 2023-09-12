//
//  UIViewController+BackButton.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addCustomBackButton(action: Selector?) {
        navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(title: nil, image: UIImage(named: "back"), target: self, action: action)
        backButton.width = 44
        navigationItem.leftBarButtonItem = backButton
    }
}
