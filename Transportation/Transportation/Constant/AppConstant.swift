//
//  AppConstant.swift
//  Transportation
//
//  Created by Anil Kothari on 11/09/23.
//

import Foundation

enum AppConstant {
    enum Spacing: CGFloat {
        case standard = 4.0
        case large = 8.0
        
        var value: CGFloat {
            return self.rawValue
        }
    }
    
    enum Anchor: CGFloat {
        case standard = 16.0
        
        var value: CGFloat {
            return self.rawValue
        }
    }
    
    enum Font: CGFloat {
        case big = 18
        case medium = 14
        
        var value: CGFloat {
            return self.rawValue
        }
    }
    
    enum AccessibilityIdentifier {
        case trainListTableView
        case stationListTableView
        
        var value: String {
            switch self {
            case .trainListTableView:
                return "TrainListTableView"
            case .stationListTableView:
                return "StationListTableView"
            }
        }
    }
}
