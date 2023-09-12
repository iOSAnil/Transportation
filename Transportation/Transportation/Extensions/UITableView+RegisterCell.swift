//
//  UITableView+RegisterCell.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import UIKit

// Mark: - TableView registration
extension UITableView {
    func register<T: UITableViewCell>(cells: [T.Type]) {
        for cell in cells {
            register(cell, forCellReuseIdentifier: String(describing: T.self))
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(reusableIdentifier: String? = nil, forIndexPath indexPath: IndexPath) -> T {
        let reusableIdentifier = reusableIdentifier ?? String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? T else {
            fatalError("cannot dequeue cell")
        }
        return cell
    }
}

// Mark: - TableView initialization
extension UITableView {
    convenience init(delegate: UITableViewDelegate,
                     dataSource: UITableViewDataSource,
                     rowHeight: CGFloat = UITableView.automaticDimension) {
        self.init(autoLayout: true)
        self.dataSource = dataSource
        self.delegate = delegate
        self.rowHeight = rowHeight
    }
}
