//
//  FeedCell.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/22/24.
//

import SwiftUI

struct FeedCell: View {
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    var showsCategory: Bool = false
    
    
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing){
            ZStack {
                Color.black.opacity(0.20)
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading){
                    
                    
                    
                    //MARK: USERNAME
                    HStack{
                        
                        ///image
                        ZStack {
                            VStack {
                                Spacer()
                                
                            }
                            .zIndex(1.0)
                            
                            
                            VStack{
                                HStack{
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .foregroundStyle(appTint)
                                        .frame(width: 40, height: 40)
                                        .overlay {
                                            Image("nullProfile")
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .padding(3)
                                        }
                                        .shadow(color: .gray, radius: 2, x:2, y: 2)
                                        .padding(.leading)
                                    Spacer()
                                        .frame(width: UIScreen.main.bounds.width, height:50)
                                        .offset(x: 10, y: -50)
                                        .padding(.leading, 20)
                                    
                                    Text("\(String(transaction.title.prefix(1)))")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 45, height: 45)
                                        .background(transaction.color.gradient, in: .circle)
                                }
                                VStack(alignment: .leading, spacing: 4, content: {
                                    Text(transaction.title)
                                        .foregroundStyle(Color.primary)
                                    
                                    if !transaction.remarks.isEmpty {
                                        Text(transaction.remarks)
                                            .font(.caption)
                                            .foregroundStyle(Color.primary.secondary)
                                    }
                                    
                                    Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                                        .font(.caption2)
                                        .foregroundStyle(.gray)
                                    
                                    if showsCategory {
                                        Text(transaction.category)
                                            .font(.caption2)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 2)
                                            .foregroundStyle(.white)
                                            .background(transaction.category == Category.income.rawValue ? Color.green.gradient : Color.red.gradient, in: .capsule)
                                    }
                                })
                                .lineLimit(1)
                                Text(currencyString(transaction.amount, allowedDigits: 2))
                                    .fontWeight(.semibold)
                            }
                            .frame(width: UIScreen.main.bounds.width, height:100)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height:100)
                }
            }
        } actions: {
            Action(tint: .red, icon: "trash") {
                context.delete(transaction)
                //           WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}
