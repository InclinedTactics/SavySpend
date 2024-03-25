//
//  TimeZoneView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/25/24.
//

import SwiftUI

struct TimeZoneView: View {
    @State var width = UIScreen.main.bounds.width
    
    @State var area = "Americas"
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color.black.opacity(0.15).ignoresSafeArea()
                    VStack(alignment: .center){
                        Text("Time Zone")
                            .foregroundStyle(.white)
                            .fontDesign(.serif)
                            .font(.system(size: 20))
                            .padding(.bottom, 35.0)
                            .shadow(color: .black, radius: 2, x: 2, y: 1)
                        Text("Select Your Geography")
                            .foregroundStyle(.white)
                            .fontDesign(.serif)
                            .font(.system(size: 25))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                        Text("To receive notifications during daylight hours, choose your respective geographical area.")
                            .fontDesign(.serif)
                            .font(.system(size: 14))
                            .foregroundStyle(.primary)
                            .fontWeight(.thin)
                            .padding(.horizontal)
                            .padding(.bottom, 55)
                        Form{
                            Button{
                                self.area = "Americas"
                            } label: {
                                TimeZoneRow(tzIcon: "globe.americas.fill", tzName: "Americas")
                                    .foregroundStyle(.primary)
                                    .fontDesign(.serif)
                                    .font(.system(size: 20))
                                    .padding(.horizontal, 15)
                            }
                            
                            
                            Button{
                                self.area = "Europe"
                            } label: {
                                TimeZoneRow(tzIcon: "globe.europe.africa.fill", tzName: "Europe")
                                    .foregroundStyle(.primary)
                                    .fontDesign(.serif)
                                    .font(.system(size: 20))
                                    .padding(.horizontal, 15)
                            }
                            
                            
                            Button{
                                self.area = "East Asia"
                            } label: {
                                TimeZoneRow(tzIcon: "globe.asia.australia.fill", tzName: "East Asia")
                                    .foregroundStyle(.primary)
                                    .fontDesign(.serif)
                                    .font(.system(size: 20))
                                    .padding(.horizontal, 15)
                            }
                            
                            
                            Button{
                                self.area = "West Asia"
                            } label: {
                                TimeZoneRow(tzIcon: "globe.asia.australia.fill", tzName: "West Asia")
                                    .foregroundStyle(.primary)
                                    .fontDesign(.serif)
                                    .font(.system(size: 20))
                                    .padding(.horizontal, 15)
                            }
                        }
                        .background(Color.gray.opacity(0.1))
                            .frame(width: width * 0.90, height: 250 )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            RoundedRectangle(cornerRadius: 12)
                             
                            
                        })
                        .overlay (Text("Save")
                            .fontDesign(.serif)
                            .font(.system(size: 20))
                            .foregroundStyle(.white))
                        .frame(width: width * 0.8, height: 40)
                        .padding(.bottom, 100)
                    }
                    .padding(.horizontal)
                }
                
            }
        }
        
    }
}
       
#Preview {
    TimeZoneView()
}
