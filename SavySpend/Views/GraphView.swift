//
//  ChartsView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI
import Charts
import SwiftData

struct GraphView: View {
    @State private var chartGroups: [ChartGroup] = []
    @State private var isLoading: Bool = false
    @State private var isSaved: Bool = false
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 10) {
                    
                    ForEach(chartGroups) { group in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(format(date: group.date, format: "MMM yyyy"))
                                .font(.callout)
                                .foregroundStyle(.gray)
                                .hSpacing(.leading)
                            NavigationLink {
                                ListOfExpenses(month: group.date)
                            } label: {
                                ChartView()
                                    .frame(height: 200)
                                    .padding(10)
                                    .padding(.top, 10)
                                    .background(.background, in: .rect(cornerRadius: 10))
                                    .opacity(chartGroups.isEmpty ? 0 : 1)
                                
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(15)
                
                
            }
           
            .onAppear {
                /// Intial Chart Group Creation
                if chartGroups.isEmpty {
                    isSaved = true
                }
                createChartGroup()
            }
        }
        /// Only Refreshes Graph Content if there is any change in data
        .onReceive(NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)) { _ in
            isSaved = true
        }
    }
    @ViewBuilder
    func ChartView() -> some View {
        /// Chart View
        Chart {
            ForEach(chartGroups) { group in
                ForEach(group.categories) { chart  in
                    BarMark(
                        x: .value("Month", format(date: group.date, format: "MMM yy")),
                        y: .value(chart.category.rawValue, chart.totalValue),
                        width: 20
                    )
                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
                }
            }
        }
        /// Making Chart Scrollable
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        .chartLegend(position: .bottom, alignment: .trailing)
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                let doubleValue = value.as(Double.self) ?? 0
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    Text(axisLabel(doubleValue))
                }
            }
        }
        /// Foreground Colors
        .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient, Color.blue.gradient, Color.mint.gradient])
    }
    func createChartGroup() {
        guard isSaved && !isLoading else { return }
        isLoading = true
        DispatchQueue.global(qos: .userInteractive).async {
            let descriptor = FetchDescriptor<Transaction>()
            guard let transactions = try? context.fetch(descriptor) else { return }
            let calendar = Calendar.current
            let groupedByDate = Dictionary(grouping: transactions) { transaction in
                let components = calendar.dateComponents([.month, .year], from: transaction.dateAdded)
                
                return components
            }
            /// Sorting Groups By Date
            let sortedGroups = groupedByDate.sorted {
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            let chartGroups = sortedGroups.compactMap { dict -> ChartGroup? in
                let date = calendar.date(from: dict.key) ?? .init()
                let income = dict.value.filter({ $0.category == Category.income.rawValue })
                let expense = dict.value.filter({ $0.category == Category.expense.rawValue })
                let savings = dict.value.filter({ $0.category == Category.savings.rawValue })
                let investment = dict.value.filter({ $0.category == Category.investment.rawValue })
                let incomeTotalValue = total(income, category: .income)
                let expenseTotalValue = total(expense, category: .expense)
                let savingsTotalValue = total(savings, category: .savings)
                let investmentTotalValue = total(investment, category: .investment)
                return .init(
                    date: date,
                    categories: [
                        .init(totalValue: incomeTotalValue, category: .income),
                        .init(totalValue: expenseTotalValue, category: .expense),
                        .init(totalValue: investmentTotalValue, category: .investment),
                        .init(totalValue: savingsTotalValue, category: .savings)
                    ],
                    totalIncome: incomeTotalValue,
                    totalExpense: expenseTotalValue,
                    totalInvestment: investmentTotalValue,
                    totalSavings: savingsTotalValue
                )
            }
            /// UI Must be updated on Main Thread
            DispatchQueue.main.async {
                self.chartGroups = chartGroups
                isLoading = false
                isSaved = false
            }
        }
    }
    func axisLabel(_ value: Double) -> String {
        let intValue = Int(value)
        let kValue = intValue / 1000
        
        return intValue < 1000 ? "\(intValue)" : "\(kValue)K"
    }
}
/// List Of Transactions for the Selected Month
struct ListOfExpenses: View {
    @State private var chartGroups: [ChartGroup] = []
    let month: Date
    /// View Properties
    @State private var selectedTransaction: Transaction?
    var body: some View {
        
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 15) {
                            Section {
                                FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .income) { transactions in
                                    ForEach(transactions) { transaction in
                                        TransactionCardView(transaction: transaction)
                                            .onTapGesture {
                                                selectedTransaction = transaction
                                            }
                                    }
                                }
                            } header: {
                                Text("Income")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .hSpacing(.leading)
                            }
                            Section {
                                FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .expense) { transactions in
                                    ForEach(transactions) { transaction in
                                        TransactionCardView(transaction: transaction)
                                            .onTapGesture {
                                                selectedTransaction = transaction
                                            }
                                    }
                                }
                            } header: {
                                Text("Expense")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .hSpacing(.leading)
                            }
                            Section {
                                FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .savings) { transactions in
                                    ForEach(transactions) { transaction in
                                        TransactionCardView(transaction: transaction)
                                            .onTapGesture {
                                                selectedTransaction = transaction
                                            }
                                    }
                                }
                            } header: {
                                Text("Savings")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .hSpacing(.leading)
                            }
                            Section {
                                FilterTransactionsView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .investment) { transactions in
                                    ForEach(transactions) { transaction in
                                        TransactionCardView(transaction: transaction)
                                            .onTapGesture {
                                                selectedTransaction = transaction
                                            }
                                    }
                                }
                            } header: {
                                Text("Investments")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .hSpacing(.leading)
                            }
                        }
                        .padding(15)
                    }
                    .background(.black.opacity(0.2))
                    .navigationTitle(format(date: month, format: "MMM yyyy"))
                    .navigationDestination(item: $selectedTransaction) { transaction in
                        TransactionsView()
                    }
                }
            }
#Preview {
    GraphView()
}
