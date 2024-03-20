//
//  UIConstants.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI

@Observable
class UIConstants {
    static let shared = UIConstants()
    
    var appTint: String = UserDefaults.standard.string(forKey: "appTint") ?? "colorOrange"
    
    var tintColor: Color {
        return tints.first { $0.color == appTint }?.value ?? .blue
    }
}

