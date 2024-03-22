//
//  DateFilterView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date, Date) -> ()
    var onClose: () -> ()
    var body: some View {
        VStack(spacing: 15) {
            DatePicker("Start Date", selection: $start, displayedComponents: [.date])
            DatePicker("End Date", selection: $end, displayedComponents: [.date])
            HStack(spacing: 15) {
                Button("Cancel") {
                    onClose()
                    HapticManager.notification(type: .success)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(.red)
                Button("Update") {
                    onSubmit(start, end)
                    HapticManager.notification(type: .success)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(appTint)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: 320)
        .padding(15)
        .background(.colorTitanium, in: .rect(cornerRadius: 10))
       
    }
}
