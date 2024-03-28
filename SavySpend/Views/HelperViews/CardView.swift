//
//  CardView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/20/24.
//



import SwiftUI

struct CardView: View {
    var income: Double
    var expense: Double
    var savings: Double
    var investments: Double
    @State private var showSettings: Bool = false
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    
    var body: some View {
        NavigationStack{
            ZStack{
                ///Balance Remaining Stack
                VStack {
                    VStack(spacing: 5 ) {
                        VStack(alignment: .leading, content: {
                            Text(" \(currencyString(income - (savings + expense + investments)))")
                                .font(.title.bold())
                                .fontDesign(.serif)
                                .foregroundStyle((expense + savings + investments) - income > income ? .colorRed1 : .colorGreen1)
                            Text("Balance")
                                .font(.title3)
                                .fontDesign(.serif)
                                .fontWeight(.light)
                                .foregroundStyle(.primary)
                                .padding(.horizontal, 15)
                                .padding(.bottom,10)//key
                        })
                        
                        //progress bar stack
                        VStack{
                            ForEach(Category.allCases, id: \.rawValue) { category in
                                //Savings
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(LinearGradient(colors: [.secondary, .colorTitanium], startPoint: .bottom, endPoint: .top).opacity(0.3))
                                        .frame(height: 40)  //height adjust
                                    ZStack(alignment: .trailing){
                                        Capsule().fill(Color.black.opacity(0.3))
                                        Text("").padding(3).font(.caption).foregroundStyle(Color.colorTitanium).padding(.trailing)
                                    }
                                    .frame(height: 10)
                                    Capsule()
                                        .fill(.colorGreen1)
                                        .frame(width: 280, height: 20)
                                        .padding(.horizontal, 2)
                                        .frame(height:7)
                                    if category == .income {
                                        HStack{
                                            // category results for progress bar
                                            Text(category.rawValue)
                                                .font(.callout)
                                                .fontDesign(.serif)
                                                .fontWeight(.light)
                                                .foregroundStyle(.primary)
                                            Spacer()
                                            Text(currencyString(income, allowedDigits: 0))
                                                .font(.callout)
                                                .fontDesign(.serif)
                                                .fontWeight(.light)
                                                .foregroundStyle(.primary)
                                        }.padding(.horizontal)
                                    }
                                    if category == .expense {
                                        HStack{
                                            // category results for progress bar
                                            Text(category.rawValue)
                                                .font(.callout)
                                                .fontDesign(.serif)
                                                .fontWeight(.light)
                                                .foregroundStyle(.primary)
                                            Spacer()
                                            Text(currencyString(expense, allowedDigits: 0))
                                                .font(.callout)
                                                .fontDesign(.serif)
                                                .fontWeight(.light)
                                                .foregroundStyle(.primary)
                                        }.padding(.horizontal)
                                    }
                                    HStack{
                                        if category == .savings {
                                            HStack{
                                                // category results for progress bar
                                                Text(category.rawValue)
                                                    .font(.callout)
                                                    .fontDesign(.serif)
                                                    .fontWeight(.light)
                                                    .foregroundStyle(.primary)
                                                Spacer()
                                                Text(currencyString(savings, allowedDigits: 0))
                                                    .font(.callout)
                                                    .fontDesign(.serif)
                                                    .fontWeight(.light)
                                                    .foregroundStyle(.primary)
                                            }.padding(.horizontal)
                                        }
                                    }
                                    HStack{
                                        if category == .investment {
                                            // category results for progress bar
                                            Text(category.rawValue)
                                                .font(.callout)
                                                .fontDesign(.serif)
                                                .fontWeight(.light)
                                                .foregroundStyle(.primary)
                                            Spacer()
                                            Text(currencyString(investments, allowedDigits: 0))
                                                .font(.callout)
                                                .fontDesign(.serif)
                                                .fontWeight(.light)
                                                .foregroundStyle(.primary)
                                        }
                                    }.padding(.horizontal)
                                }.hSpacing(.center)
                            }
                        }.padding(.horizontal, 5)
                    }
                }.padding()
                Spacer()
            }.hSpacing(.leading)
        }
    }
}
#Preview {
    CardView(income: 1234, expense: 652346, savings: 56432, investments: 45789)
    }
