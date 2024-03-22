//
//  BudgetsView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/20/24.
//

import SwiftUI

struct BudgetsView: View {
    //MARK:  PROPERTIES
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    /// User Properties
    @AppStorage("userName") private var userName: String = ""
    /// View Properties
    @State private var showFilterView: Bool = false
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var addBudget: Bool = false
    @State private var selectedBudget: Budget?
    /// For Animation
    @Namespace private var animation
    var body: some View {
        GeometryReader {
            /// For Animation Purpose
            let size = $0.size
            NavigationStack {
                ScrollView(.vertical){
                    LazyVStack(spacing: 5, pinnedViews: [.sectionHeaders]){
                        Section{
                            
                            
                            
                        } header: {
                            HeaderView(size)
                        }.padding(2)
                    }
                }
            }
        }
    }
    /// Header View
         @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        NavigationStack{
            HStack(spacing: 10) {
                
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Budgets")
                        .font(.title.bold())
                    if !userName.isEmpty {
                        Text(userName)
                            .font(.callout)
                            .foregroundStyle(.gray)
                    } else {
                        Text("...establish your plan of attack.")
                            .font(.callout.bold())
                            .fontDesign(.serif)
                            .foregroundStyle(.secondary)
                    }
                })
                .offset(x: 40.0)
                Spacer(minLength: 0)
                ///add budget button
                NavigationLink {
                    AddBudget()
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 45, height: 45)
                        .background(appTint.gradient, in: .circle)
                        .contentShape(.circle)
                }
            }
            .padding(.horizontal,7)
            .padding(.bottom, userName.isEmpty ? 10 : 5)
            .background {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                }
                .visualEffect { content, geometryProxy in
                    content
                        .opacity(headerBGOpacity(geometryProxy))
                }
                .padding(.top, -(safeArea.top + 15))
            }
        }
    }
             func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
                         let minY = proxy.frame(in: .scrollView).minY + safeArea.top
                         return minY > 0 ? 0 : (-minY / 15)
                     }
                     func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
                         let minY = proxy.frame(in: .scrollView).minY
                         let screenHeight = size.height
                         
                         let progress = minY / screenHeight
                         let scale = (min(max(progress, 0), 1)) * 0.4
                         
                         return 1 + scale
                     }
}
#Preview {
    BudgetsView()
}
