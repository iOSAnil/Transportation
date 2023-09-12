//
//  TransportationTests.swift
//  TransportationTests
//
//  Created by Anil Kothari on 10/09/23.
//

import XCTest
@testable import Transportation

final class NetworkAPITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTubeLineInfoAppId() throws {
        let api = TransportForLondonAPI.tubeLineInfo
        XCTAssertEqual(api.appId, "com.tfl")
    }

    func testTubeLineInfoPath() throws {
        let api = TransportForLondonAPI.tubeLineInfo
        XCTAssertEqual(api.path, "/Line/Mode/tube")
    }

    func testTubeLineInfoDomain() throws {
        let api = TransportForLondonAPI.tubeLineInfo
        XCTAssertEqual(api.domain, "https://api.tfl.gov.uk")
    }

    func testTubeLineInfoAppKey() throws {
        let api = TransportForLondonAPI.tubeLineInfo
        XCTAssertEqual(api.appKey, "130342c83ef347bd979ceea042cf2e0f")
    }

    func testTubeLineInfoQueryString() throws {
        let api = TransportForLondonAPI.tubeLineInfo
        let components = api.queryString.components(separatedBy: "&")

        // First component
        let keys = components.first?.components(separatedBy: "=") ?? []
        for key in keys {
            if key == "app_key" {
                XCTAssertEqual(keys.last, api.appKey)
            } else if key == "app_id" {
                XCTAssertEqual(keys.last, api.appId)
            }
        }
    }

    func testTubeLineInfoUrl() throws {
        let api = TransportForLondonAPI.tubeLineInfo
        XCTAssertTrue(api.url.hasPrefix("https://api.tfl.gov.uk/Line/Mode/tube"))
    }

    func testRouteInfoAppId() throws {
        let api = TransportForLondonAPI.routeInformation(lineId: "victoria")
        XCTAssertEqual(api.appId, "com.tfl")
    }

    func testRouteInfoPath() throws {
        let api = TransportForLondonAPI.routeInformation(lineId: "victoria")
        XCTAssertEqual(api.path, "/Line/victoria/Route/Sequence/outbound")
    }

    func testRouteInfoDomain() throws {
        let api = TransportForLondonAPI.routeInformation(lineId: "victoria")
        XCTAssertEqual(api.domain, "https://api.tfl.gov.uk")
    }

    func testRouteInfoAppKey() throws {
        let api = TransportForLondonAPI.routeInformation(lineId: "victoria")
        XCTAssertEqual(api.appKey, "130342c83ef347bd979ceea042cf2e0f")
    }

    func testRouteInfoQueryString() throws {
        let api = TransportForLondonAPI.routeInformation(lineId: "victoria")
        let components = api.queryString.components(separatedBy: "&")

        // First component
        let keys = components.first?.components(separatedBy: "=") ?? []
        for key in keys {
            if key == "app_key" {
                XCTAssertEqual(keys.last, api.appKey)
            } else if key == "app_id" {
                XCTAssertEqual(keys.last, api.appId)
            }
        }
    }

    func testRouteInfoUrl() throws {
        let api = TransportForLondonAPI.routeInformation(lineId: "victoria")
        XCTAssertTrue(api.url.hasPrefix("https://api.tfl.gov.uk/Line/victoria/Route/Sequence/outbound"))
    }
}
