//
//  TintColor.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI

/// Custom Tint Colors For Transaction Row
struct TintColor: Identifiable {
    let id: UUID = .init()
    var color: String
    var value: Color
}

var tints: [TintColor] = [
    .init(color: "Red", value: .colorRed),
    .init(color: "Blue", value: .colorBlue),
    .init(color: "Pink", value: .colorPink),
    .init(color: "Purple", value: .colorPurple),
    .init(color: "Orange", value: .colorOrange),
    .init(color: "Gray", value: .colorGrey),
    .init(color: "Green", value: .colorGreen),
    .init(color: "Titanium", value: .colorTitanium),
    .init(color: "ODGreen", value: .colorODGreen),
    .init(color: "Yellow", value: .colorYellow),
]



