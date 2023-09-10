//
//  Publisher.swift
//  Transportation
//
//  Created by Anil Kothari on 10/09/23.
//

import Foundation

final class Publisher<T> {
    public var value: T {
        didSet {
            self.subscriptions.allObjects.forEach {
                $0.notify(value)
            }
        }
    }
    
    private var subscriptions = NSHashTable<Subscription<T>>.weakObjects()
    
    public var hasSubscriptions: Bool {
        return subscriptions.allObjects.isEmpty == false
    }

    public init(value: T) {
        self.value = value
    }
    
    public func unsubscribe(_ subscription: Subscription<T>) {
        subscription.stop()
        subscriptions.remove(subscription)
    }
    
    public func subscribe(publishImmediately: Bool = false,
                          _ onChange: @escaping ((T)-> Void)) -> Subscription<T> {
        let sub = Subscription(onChange)
        
        self.subscriptions.add(sub)
        
        if publishImmediately {
            onChange(value)
        }
        return sub
    }
}

