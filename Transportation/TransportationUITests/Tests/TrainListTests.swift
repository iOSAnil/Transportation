//
//  TransportationUITests.swift
//  TransportationUITests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest

final class TrainListTests: XCTestCase {
    let trainListScreen = TrainListScreen()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTrainListScreenElements() {
        trainListScreen.launchScreen()
        trainListScreen.verifyUI()
        trainListScreen.tapOnCircleLineTrainCell()
    }
}
