//
//  TrainInformationModelTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class TrainInformationModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrainInformationModelEmptyServices() {
        let trainListStationModel = TrainInformationModel(tubeModel: TrainLineModel.init(type: nil, id: nil, name: nil, modeName: nil, serviceTypes: nil))
        XCTAssertTrue(trainListStationModel.services.isEmpty)
    }

}
