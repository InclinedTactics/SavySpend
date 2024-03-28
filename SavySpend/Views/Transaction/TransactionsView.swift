//
//  TransactionsView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/25/24.
//

import SwiftUI
import SwiftData

struct TransactionsView: View {
    //MARK:  PROPERTIES
    /// User Properties
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userName") private var userEmail: String = ""
    @AppStorage("userName") private var name: String = ""
    /// View Properties
    @State private var showFilterView: Bool = false
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var addTransaction: Bool = false
    @State private var showMetrics: Bool = false
    @State private var showProfile = false
    @State private var selectedCategory: Category = .expense
    @State private var selectedTransaction: Transaction?
    @State private var selectedTab = 0
    
    /// SideMenu View Properties
    @State private var showMenu: Bool = false
    @State private var rotateWhenExpands: Bool = true
    @State private var disablesInteractions: Bool = false
    @State private var disableCorners: Bool = false
    
    
    /// For Animation
    @Namespace private var animation
    var body: some View {
        GeometryReader {
            /// For Animation Purpose
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical){
                    LazyVStack(spacing: 0.5, pinnedViews: [.sectionHeaders]){
                        //MARK: SECTION
                        Section{
                            
                            VStack{
                                FilterTransactionsView(startDate: startDate, endDate: endDate, category: selectedCategory) { transactions in
                                    /// Card View
                                    GraphView()
                                }
                                .padding(.bottom, 5)
                                .padding(.horizontal, 7)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.bottom, 10)
                                ///  CATEGORY SEGMENTED PICKER
                                Picker("", selection: $selectedCategory) {
                                    ForEach(Category.allCases, id: \.rawValue) { category in
                                        Text("\(category.rawValue)")
                                            .tag(category)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 5)
                                
                                ///MARK:  FILTER TRANSACTION VIEW
                                FilterTransactionsView(startDate: startDate, endDate: endDate, category: selectedCategory) { transactions in
                                    ForEach(transactions){ transaction in
                                        TransactionCardView(transaction: transaction)
                                            .onTapGesture {
                                                selectedTransaction = transaction
                                            }
                                    }
                                    .padding(.top, 10)
                                }
                                .animation(.none, value: selectedCategory)
                            }.blur(radius: showProfile ? 8 : 0)
                            //MARK: HEADER
                        } header: {
                            HeaderView(size)
                                .padding(.bottom,10)
                        }
                        .background(Color.white.opacity(0.2).gradient, in: .rect).cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .background(.black.opacity(0.05).gradient)
                .blur(radius: showFilterView ? 8 : 0)
                .disabled(showFilterView)
                .navigationDestination(item: $selectedTransaction) { transaction in
                    EditTransaction(editTransaction: transaction)
                }
            }
            ///endOf navigation stack:  .navigationDestination requires wrap of nav stack
            //MARK: SHOW DATE FILTER VIEW
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: {start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
            .background(
                Rectangle()
                    .fill(.clear)
            )
        }
    }
           
        //  MARK: Header View
        @ViewBuilder
        func HeaderView(_ size: CGSize) -> some View {
            NavigationStack{
                HStack(spacing: 10) {
                    NavigationLink{
                        EditProfile()
                    } label: {
                        VStack{
                            ZStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 47, height: 47)
                                    .shadow(color: .primary, radius: 1, x: 1, y: 1)
                                
                                Image("boys")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 42, height: 42)
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Welcome!")
                            .fontDesign(.serif)
                            .font(.title.bold())
                            .padding(.leading)
                        if !userName.isEmpty {
                            Text(userName)
                                .font(.callout)
                                .fontDesign(.serif)
                                .foregroundStyle(.gray)
                        } else {
                            Text("...your personal Balance Sheet.")
                                .font(.callout.bold())
                                .fontDesign(.serif)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer(minLength: 0)
                    NavigationLink {
                        AddTransaction()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 42, height: 42)
                            .background(appTint, in: .circle)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                    }
                    
                }
                .blur(radius: showProfile ? 8 : 0)
                .padding(.horizontal,7)
                .padding(.bottom, userName.isEmpty ? 10 : 5)
                
                .background {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(.black.opacity(0.01))
                    }
                    .visualEffect { content, geometryProxy in
                        content
                            .opacity(headerBGOpacity(geometryProxy))
                    }
                    .padding(.top, -(safeArea.top + 15))
                }
                ZStack {
                    HStack{
                        ///MARK:  DATE FILTER BUTTON
                        Button {
                            showFilterView = true
                            HapticManager.notification(type: .success)
                        }  label: {
                            Image(systemName: "calendar")
                                .font(.title)
                                .foregroundStyle(appTint)
                            Text("\(format(date: startDate,format: "dd MMM yy")) - \(format(date: endDate,format: "dd MMM yy"))")
                                .font(.system(size: 18))
                                .fontDesign(.serif)
                                .fontWeight(.bold)
                                .foregroundStyle(appTint)
                                .frame(width: 200)
                            
                        }
                        .padding(10)
                        .padding(.horizontal)
                        .frame(width: 250)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.colorTitanium.gradient)
                                .hSpacing(.center)
                        }
                    }.hSpacing(.center)
                    
                    Spacer()
                    ///MARK:  BUTTON MENU
                    
                        .frame(width: 372)
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
