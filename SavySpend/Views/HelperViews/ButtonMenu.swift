//
//  ButtonMenu.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI

struct ButtonMenu: View {
    @State private var showBudget: Bool = false
    @State private var showMetrics: Bool = false
    @State private var showSettings: Bool = false
    @State private var showProfile: Bool = false
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    
    
    var body: some View {
        NavigationStack{
            HStack{
                Button {
                    showMetrics = true
                    HapticManager.notification(type: .success)
                } label: {
                    VStack{
                        Image(systemName: "chart.pie.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(appTint)
                            .frame(width: 30, height: 30)
                            .padding(3)
                        Text("Charts")
                            .font(.caption)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                }.frame(maxWidth: 50, maxHeight: 80)
                    .sheet(isPresented: $showMetrics) {
                        GraphView()
                            .presentationDetents([.large])
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.colorTitanium.gradient)
                            .shadow(color: .black, radius: 3)
                    }
                Spacer()
                //MARK:   BUDGET BUTTON
                Button {
                    showBudget = true
                    HapticManager.notification(type: .success)
                } label: {
                    VStack{
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(appTint)
                            .frame(width: 30, height: 30)
                        Text("Budget")
                            .font(.caption)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    .frame(maxWidth: 50, maxHeight: 80)
                    .sheet(isPresented: $showBudget) {
                        BudgetsView()
                            .presentationDetents([.large])
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.colorTitanium.gradient)
                        .shadow(color: .black, radius: 3)
                }
            }
            .hSpacing(.center)
        }
    }
}

#Preview {
    ButtonMenu()
}
