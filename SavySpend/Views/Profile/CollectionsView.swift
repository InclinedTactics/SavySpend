//
//  CollectionsView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/22/24.
//

import SwiftUI

struct CollectionsView: View {
    //Properties
    var day: Int
    
    var body: some View {
        VStack {
            ZStack {
                //Overlay of qty pics
                Text("\(day)")
                    .foregroundStyle(.white)
                    .shadow(color: .black, radius: 2, x: 1, y:1)
                    .zIndex(1.0)
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: UIScreen.main.bounds.width / 7.20, height: 80)
                    .foregroundStyle(.blue)
                
               Image("boys")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 8, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    CollectionsView(day: 17)
}
