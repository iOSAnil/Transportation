//
//  SubscriptionTests.swift
//  SubscriptionTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class SubscriptionTests: XCTestCase {
    var subscription: Subscription<String>?
    var value: String = ""

    var publisher: Publisher<String>?
    var publisherValue: String = ""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSubscription() throws {

        subscription = Subscription({ value in
            self.value = value
        })

        subscription?.notify("testValue")
        XCTAssertEqual(value, "testValue")

        subscription?.notify("testValue1")
        XCTAssertEqual(value, "testValue1")

        subscription?.stop()
        subscription?.notify("testValue2")
        XCTAssertEqual(value, "testValue1")
    }

    func testPublisher() throws {
        publisher = Publisher(value: "testValue")

        subscription = publisher?.subscribe({ value in
            self.value = value
        })

        publisher?.value = "testValue"

        XCTAssertEqual(value, "testValue")

        publisher?.value = "testValue2"
        XCTAssertEqual(value, "testValue2")

        if let subscription = subscription {
            publisher?.unsubscribe(subscription)
        }

        publisher?.value = "testValue3"
        XCTAssertNotEqual(value, "testValue3")
        XCTAssertEqual(value, "testValue2")
    }
}
