//
//  String+Localized.swift
//  Transportation
//
//  Created by Anil Kothari on 11/09/23.
//

import Foundation

enum StringConstant: String {
    case trains
    case services
    case errorMessage
    case errorTitle
    case okText
    case lineStations
    case stations
    case station
    
    func localized() -> String {
        return NSLocalizedString(self.rawValue, bundle: Bundle.main, comment: self.rawValue)
    }
}
