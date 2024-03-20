//
//  SettingsHeaderView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI

struct SettingsHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Joseph W. DeWeese")
                    .font(.callout)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                Text("@Inclined Tactics")
                    .font(.caption2)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SettingsHeaderView()
}
