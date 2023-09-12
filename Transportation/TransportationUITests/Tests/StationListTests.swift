//
//  TransportationUITests.swift
//  TransportationUITests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest

final class StationListTests: XCTestCase {
    let trainListScreen = TrainListScreen()
    let stationListScreen = StationListScreen()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStationListScreen() {
       trainListScreen.launchScreen()
       trainListScreen.verifyUI()
       trainListScreen.tapOnCircleLineTrainCell()
       stationListScreen.verifyUI()
    }
}
