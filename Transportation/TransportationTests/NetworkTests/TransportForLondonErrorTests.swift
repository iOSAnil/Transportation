//
//  TransportForLondonErrorTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class TransportForLondonErrorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIFailureErrorMessage() throws {
        let api = TransportForLondonError.apiFailure
        XCTAssertEqual(api.message, StringConstant.errorMessage.localized())
    }

    func testParseErrorMessage() throws {
        let api = TransportForLondonError.parseError
        XCTAssertEqual(api.message, StringConstant.errorMessage.localized())
    }

    func testAPIFailureServerMessage() throws {
        let api = TransportForLondonError.serverMessage(error: "server Error")
        XCTAssertEqual(api.message, "server Error")
    }
}
