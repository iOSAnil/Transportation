//
//  DecoableTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class DecoableTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodableParseError() {
        do {
            _ = try "TrainList".getData().decode(StationModel.self)
            XCTFail("TrainList should not parse the Station model")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testDecodableParseSuccess() {
        do {
            let model = try "victoria".getData().decode(StationModel.self)
            XCTAssertEqual((model.stations ?? []).count, 16)
        } catch {
            XCTFail("victoria file should be decoded to Station model")
        }
    }
}
