//
//  TrainListItemViewStateTest.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class TrainListItemViewStateTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrainLineModel() {
        guard let trainLineModel = TrainLineModel.mockList.first else {
            fatalError("first Model should not be nil")
        }
        let model =  TrainInformationModel(tubeModel: trainLineModel)

        XCTAssertEqual(model.tubeLineId, "bakerloo")
        XCTAssertEqual(model.tubeLineName, "Bakerloo")
        XCTAssertEqual(model.services.count, 1)
    }

    func testLoadingEquatable() {
        let lhs = TrainListItemViewState.loading
        let rhs = TrainListItemViewState.loading
        XCTAssertEqual(lhs, rhs)
    }

    func testLoadEquatable() {
        guard let trainLineModel = TrainLineModel.mockList.first else {
            fatalError("first Model should not be nil")
        }
        let model =  TrainInformationModel(tubeModel: trainLineModel)

        let lhs = TrainListItemViewState.load([model])
        let rhs = TrainListItemViewState.load([model])
        XCTAssertEqual(lhs, rhs)
    }

    func testErrorMessageEqual() {
        let lhs = TrainListItemViewState.error(message: "")
        let rhs = TrainListItemViewState.error(message: "")
        XCTAssertEqual(lhs, rhs)
    }

    func testErrorMessageNotEqual() {
        let lhs = TrainListItemViewState.error(message: StringConstant.errorMessage.localized())
        let rhs = TrainListItemViewState.error(message: "Api failed")
        XCTAssertNotEqual(lhs, rhs)
    }
}
