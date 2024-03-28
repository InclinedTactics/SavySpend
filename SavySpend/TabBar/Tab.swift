//
//  Tab.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/24/24.
//

import SwiftUI

/// App Tab's
enum Tab: String, CaseIterable {
    case transactions = "Transactions"
    case budget = "Budget"
    case investments = "Investments"
   case settings = "Settings"
   
    var systemImage: String {
        switch self {
        case .budget:
            return "envelope"
        case .transactions:
            return "dollarsign"
        case .investments:
            return "chart.xyaxis.line"
        case .settings:
            return "gear"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

