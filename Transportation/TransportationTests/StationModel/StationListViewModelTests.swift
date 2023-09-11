//
//  StationListViewModelTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class StationListViewModelTests: XCTestCase {
    var viewModel: StationListViewModel?
    var navigationDelegate = MockTransportNavigationFlowHandler()

    func setTestType(_ testType: MockTubeInformationAPIContext.TestType, lineId: String = "") {
        viewModel = StationListViewModel(apiHandler: MockTubeInformationAPIContext(testType: testType),
                                         lineId: lineId,
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
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { viewState in
            XCTAssertEqual(viewState, StationListViewState.loading)
            XCTAssertEqual(viewState, StationListViewModel.initialValue)
        })
    }

    func testScreenAppearEvent() throws {
        viewModel?.dispatch(event: .screenAppear)
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { viewState in
            XCTAssertEqual(viewState, StationListViewState.load(StationList(model: StationModel.mockModel)))
        })
    }

    func testScreenAppearWithErrorResponse() throws {
        setTestType(.errorMessage)
        viewModel?.dispatch(event: .screenAppear)
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { viewState in
            if case let .error(message) = viewState {
                XCTAssertEqual(message, "errorMessage")
            }
        })
    }

    func testScreenAppearWithNilModelResponse() throws {
        setTestType(.nilModel)
        viewModel?.dispatch(event: .screenAppear)
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { viewState in
            if case let .error(message) = viewState {
                XCTAssertEqual(message, "something went wrong")
            }
        })
    }

    func testBackButtonTappedEvent() throws {
        navigationDelegate.reset()
        viewModel?.dispatch(event: .backButtonTapped)
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { [weak self] _ in
            let value = self?.navigationDelegate.backButtonTapped ?? false
            XCTAssertTrue(value)
        })
    }

    func testErrorReceivedEvent() throws {
        navigationDelegate.reset()
        viewModel?.dispatch(event: .errorReceived("Something went wrong"))
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { [weak self] _ in
            let value = self?.navigationDelegate.error ?? false
            XCTAssertTrue(value)
        })
    }

    func testScreenAppearEventWithAPIFailure() throws {
        setTestType(.failure)
        viewModel?.dispatch(event: .screenAppear)
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { viewState in
            XCTAssertEqual(viewState, StationListViewState.error(message: "Something went wrong. Please try again later"))
        })
    }

    func testScreenAppearEventWithIncorrectLineId() throws {
        setTestType(.failure, lineId: "%")
        viewModel?.dispatch(event: .screenAppear)
        _ = viewModel?.publisher.subscribe(publishImmediately: true, { viewState in
            XCTAssertEqual(viewState, StationListViewState.error(message: "Something went wrong. Please try again later"))
        })
    }
}
