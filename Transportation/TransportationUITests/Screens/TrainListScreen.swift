//
//  TrainListScreen.swift
//  TransportationUITests
//
//  Created by Anil Kothari on 11/09/23.
//

import XCTest

final class TrainListScreen: BaseScreen {
    lazy var activityIndicator = app.staticTexts
    lazy var navigationBar = app.navigationBars.staticTexts["Trains"]

    lazy var tableView = app.tables["TrainListTableView"]
    lazy var circleLineElement = tableView.cells["Circle"]
    lazy var jubileeLineElement = tableView.cells["Jubilee"]
    
    func launchScreen() {
        app.launch()
    }
    
    func tapOnCircleLineTrainCell() {
        syncTap(circleLineElement)
    }
    
    func verifyUI() {
        verifyNavigationBar()
        verifyServicesInCircleLineCell()
        verifyServicesInJubileeLineCell()
    }
    
    private func verifyNavigationBar() {
        verifyUIElement(navigationBar)
    }
    
    private func verifyServicesInCircleLineCell() {
        waitThenAssertExists(circleLineElement)
        let servicesLabel = circleLineElement.staticTexts["Services:"]
        let regularLabel = circleLineElement.staticTexts["Regular"]
        [servicesLabel, regularLabel].forEach({ verifyUIElement($0)})

    }
    private func verifyServicesInJubileeLineCell() {
        waitThenAssertExists(jubileeLineElement)
        let servicesLabel = jubileeLineElement.staticTexts["Services:"]
        let regularLabel = jubileeLineElement.staticTexts["Regular"]
        let nightLabel = jubileeLineElement.staticTexts["Night"]
        [servicesLabel, regularLabel, nightLabel].forEach({ verifyUIElement($0)})
    }
}
