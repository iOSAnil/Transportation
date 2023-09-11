//
//  MockTransportNavigationFlowHandler.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class MockTransportNavigationFlowHandler: TransportNavigationFlowHandler {
    var trainIdentifierTapped = false
    var backButtonTapped = false
    var error = false

    func handleNavigationAction(_ action: Transportation.TransportNavigationAction) {
        switch action {
        case .trainIdentifierTapped:
            trainIdentifierTapped = true
        case .backButtonTapped:
            backButtonTapped = true
        case .error:
            error = true
        }
    }

    func reset() {
        trainIdentifierTapped = false
        backButtonTapped = false
        error = false
    }
}
