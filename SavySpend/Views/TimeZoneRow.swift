//
//  TimeZoneRow.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/25/24.
//

import SwiftUI

struct TimeZoneRow: View {
    var tzIcon: String = ""
    var tzName: String = ""
    
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: tzIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(appTint)
                Text(tzName)
                    .fontDesign(.serif)
                    .font(.title3)
                    .foregroundStyle(appTint)
                Spacer()
                    .padding(4)
            }
            
        }
    }
}

#Preview {
    TimeZoneRow()
}
