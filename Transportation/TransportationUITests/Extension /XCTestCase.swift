//
//  XCTestCase.swift
//  TransportationUITests
//
//  Created by Anil Kothari on 11/09/23.
//

import Foundation
import XCTest

public extension XCTestCase {
    func syncTap(_ element: XCUIElement, timeout: Int = 60) {
        waitForElementToBeHittable(element, timeout: timeout)
        element.tap()
    }
    
    
    func waitThenAssertExists(_ element: XCUIElement, timeout: Int = 30) {
        var iCounter = 1
        while iCounter < timeout {
            if element.exists {
                return
            } else {
                sleep(1)
                iCounter += 1
                print("Element \(element) not shows up..")
            }
        }
        
        if (iCounter == timeout) {
            XCTFail("Element \(element) not shows up within \(timeout) seconds.")
        }
    }
     
    func waitForElementToBeHittable(_ element: XCUIElement, timeout: Int = 60) {
        var iCounter = 1
        while iCounter < timeout {
            if element.exists && element.isHittable {
                return
            } else {
                sleep(1)
                iCounter += 1
                print("Element \(element) not shown or isHittable yet")
            }
        }
        
        if (iCounter == timeout) {
            XCTFail("Element \(element) either not shows up or hittable within \(timeout) seconds.")
        }
    }
    
    func letAppSettle(_ timeInterval: TimeInterval = 1.0) {
        Thread.sleep(forTimeInterval: timeInterval)
    }
}


class BaseScreen: XCTestCase {
    let app = XCUIApplication()
    
    func verifyUIElement(_ element: XCUIElement) {
        if !element.exists {
            XCTFail("Element \(element) is missing")
        }
    }
}
