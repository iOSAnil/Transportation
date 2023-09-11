//
//  StationListViewStateTest.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class StationListViewStateTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLineName() {
        let model = StationList(model: StationModel.mockModel)
        XCTAssertEqual(model.lineName, "Victoria Line Stations")
    }

    func testDecodableParseSuccess() {
        let model = StationList(model: StationModel.nilModel)
        XCTAssertEqual(model.lineName, "Stations")
    }

    func testStationItemViewState() {
        let model = StationItemViewState(tubeModel: Station.mockModel, id: "victoria")
        XCTAssertEqual(model.stationName, "Bermondsey Underground Station")
        XCTAssertNotNil(model.color)
    }

    func testStationItemViewStateEmptyId() {
        let model = StationItemViewState(tubeModel: Station.mockModel, id: "")
        XCTAssertTrue(model.color.isEqual(UIColor.clear))
    }

    func testStationItemViewStateNilId() {
        let model = StationItemViewState(tubeModel: Station.mockModel, id: nil)
        XCTAssertTrue(model.color.isEqual(UIColor.clear))
    }

    func testLoadingEquatable() {
        let lhs = StationListViewState.loading
        let rhs = StationListViewState.loading
        XCTAssertEqual(lhs, rhs)
    }

    func testLoadEquatable() {
        let lhs = StationListViewState.load(StationList(model: StationModel.mockModel))
        let rhs = StationListViewState.load(StationList(model: StationModel.mockModel))
        XCTAssertEqual(lhs, rhs)
    }

    func testErrorMessageEqual() {
        let lhs = StationListViewState.error(message: "")
        let rhs = StationListViewState.error(message: "")
        XCTAssertEqual(lhs, rhs)
    }

    func testErrorMessageNotEqual() {
        let lhs = StationListViewState.error(message: "something went wrong")
        let rhs = StationListViewState.error(message: "Api failed")
        XCTAssertNotEqual(lhs, rhs)
    }

}
