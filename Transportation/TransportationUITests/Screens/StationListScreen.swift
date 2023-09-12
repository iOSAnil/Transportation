//
//  StationListScreen.swift
//  TransportationUITests
//
//  Created by Anil Kothari on 11/09/23.
//

import XCTest

final class StationListScreen: BaseScreen {
    
    lazy var tableView = app.tables["StationListTableView"]
    lazy var aldgateStationCell = tableView.cells["Aldgate Underground Station"]
 
    lazy var initialNavigationBar = app.navigationBars.staticTexts["Station"]
    lazy var finalNavigationBar = app.navigationBars.staticTexts["Circle Line Stations"]

    func verifyUI() {
        verifyUIElement(initialNavigationBar)
        verifyCircleLineScreenIsRendered()
        verifyUIElement(finalNavigationBar)
    }
    
    private func verifyCircleLineScreenIsRendered() {
        waitThenAssertExists(aldgateStationCell)
        let cellsIdentifiers = ["Aldgate Underground Station",
                                "Barbican Underground Station",
                                "Baker Street Underground Station",
                                "Bayswater Underground Station"
                                ]
        cellsIdentifiers.map({ tableView.cells[$0] }).forEach({ verifyUIElement($0)})
    }
}
