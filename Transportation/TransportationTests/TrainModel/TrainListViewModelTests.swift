//
//  TrainListViewModelTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class TrainListViewModelTests: XCTestCase {
    var viewModel: TrainListViewModel?
    var navigationDelegate = MockTransportNavigationFlowHandler()

    func setTestType(_ testType: MockTubeInformationAPIContext.TestType) {
        viewModel = TrainListViewModel(apiHandler: MockTubeInformationAPIContext(testType: testType),
                                       navigationDelegate: navigationDelegate)

    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setTestType(.success)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testInitialEvent() throws {
        _ = viewModel?.publisher?.subscribe(publishImmediately: true, { viewState in
            XCTAssertEqual(viewState, TrainListItemViewState.loading)
        })
    }

    func testTubeLineTappedEvent() throws {
        viewModel?.dispatch(event: .tubeLineTapped(id: "victoria"))
        _ = viewModel?.publisher?.subscribe(publishImmediately: true, { [weak self] _ in
            let trainIdentifierTapped = self?.navigationDelegate.trainIdentifierTapped ?? false
            XCTAssertTrue(trainIdentifierTapped)
        })
    }

    func testIncorrectTubeLineTappedEvent() throws {
        viewModel?.dispatch(event: .tubeLineTapped(id: ""))
        _ = viewModel?.publisher?.subscribe(publishImmediately: true, { [weak self] _ in
            let trainIdentifierTapped = self?.navigationDelegate.trainIdentifierTapped ?? true
            XCTAssertFalse(trainIdentifierTapped)
        })
    }

    func testNilTubeLineTappedEvent() throws {
        viewModel?.dispatch(event: .tubeLineTapped(id: nil))
        _ = viewModel?.publisher?.subscribe(publishImmediately: true, { [weak self] _ in
            let trainIdentifierTapped = self?.navigationDelegate.trainIdentifierTapped ?? true
            XCTAssertFalse(trainIdentifierTapped)
        })
    }

    func testAPIFailureEvent() throws {
        setTestType(.failure)
        _ = viewModel?.publisher?.subscribe(publishImmediately: true, { viewState in
            if case let .error(message) = viewState {
                XCTAssertNotNil(message)
            }
        })
    }
}
