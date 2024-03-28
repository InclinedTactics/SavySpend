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
    ///gray
    .init(color: "colorGray", value: .colorGray),
    .init(color: "colorGray1", value: .colorGray1),
    .init(color: "colorGray2", value: .colorBrown2),
    ///blue
    .init(color: "colorBlue ", value: .colorBlue1),
    .init(color: "colorBlue1", value: .colorBlue1),
    .init(color: "colorBlue2", value: .colorBlue2),
    .init(color: "colorBlue3", value: .colorBlue3),
    .init(color: "colorBlue 4", value: .colorBlue4),
    ///yellow
    .init(color: "colorYellow1", value: .colorYellow1),
    .init(color: "colorYellow2", value: .colorYellow2),
    ///brown
    .init(color: "colorBrown", value: .colorBrown),
    .init(color: "colorBrown1", value: .colorBrown1),
    .init(color: "colorBrown2", value: .colorBrown2),
    .init(color: "colorBrown3", value: .colorBrown2),
    ///green
    .init(color: "colorGreen ", value: .colorGreen),
    .init(color: "colorGreen1", value: .colorGreen1),
    .init(color: "colorGreen2", value: .colorGreen2),
    .init(color: "colorGreen3", value: .colorGreen3),
    ///red
    .init(color: "colorRed", value: .colorRed),
    .init(color: "colorRed1", value: .colorRed1),
    .init(color: "colorRed2", value: .colorRed2),
    .init(color: "colorRed3", value: .colorRed3),
    .init(color: "colorRed4", value: .colorRed4),
    //titanium
    .init(color: "colorTitanium", value: .colorTitanium),
    
    ///orange
    .init(color: "Orange", value: .colorOrange),
    .init(color: "Orange1", value: .colorOrange1),
    .init(color: "Orange2", value:.colorOrange2),
    ///pink
    .init(color: "Pink1", value: .colorPink1),
    .init(color: "Pink2", value: .colorPink2),
    ///purple
    .init(color: "Purple", value: .colorPurple),
    .init(color: "Purple1", value: .colorPurple1),
    .init(color: "Purple2", value: .colorPurple2),
 
]



