//
//  Subscription.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation

final class Subscription<T> {
    private(set) var block: ((T) -> Void)?
    
    init(_ block: @escaping ((T) -> Void)) {
        self.block = block
    }
    
    func notify(_ value: T) {
        block?(value)
    }
    
    func stop() {
        block = nil
    }
}


