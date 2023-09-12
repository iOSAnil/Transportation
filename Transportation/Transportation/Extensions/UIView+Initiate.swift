//
//  UIView+EdgeInsets.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit

extension UIView {
    func embed(in view: UIView, edgeInsets: UIEdgeInsets) {
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1*edgeInsets.right),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1*edgeInsets.bottom),
        ])
    }
    
    @objc class func autoLayout() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    @objc convenience init(autoLayout: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = !autoLayout
    }
    
    func showLoader() {
        let activityDisplayView = ActivityIndicatorView.autoLayout()
        self.addSubview(activityDisplayView)
        activityDisplayView.embed(in: self, edgeInsets: .zero)
    }
    
    func hideLoader() {
        for v in self.subviews{
           if v is ActivityIndicatorView{
              v.removeFromSuperview()
           }
        }
    }
}


