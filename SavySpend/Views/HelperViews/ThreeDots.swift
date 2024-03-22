//
//  ThreeDots.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/22/24.
//

import SwiftUI

struct ThreeDots: View {
    
    var size: CGFloat
    var color: Color
    
    
    var body: some View {
        HStack{
            Image(systemName: "circle.fill")
                .foregroundStyle(color)
                .font(.system(size: size))
            Image(systemName: "circle.fill")
                .foregroundStyle(color)
                .font(.system(size: size))
            Image(systemName: "circle.fill")
                .foregroundStyle(color)
                .font(.system(size: size))
        }
    }
}

#Preview {
    ThreeDots(size: 10, color: .black)
}
