//
//  ProfileView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/20/24.
//

//
//  ProfileView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/20/24.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
     var name: String
    var userName: String
     var userEmail: String
     var photo: UIImage?
    @State private var isSaving: Bool = false

    var body: some View {
        VStack {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                
                //Profile Image
                VStack{
                   
                    
                    Image("boys")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                    Text("J. DeWeese")
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundStyle(.primary)
                    Text("@inclinedTactics")
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    //Collection Title Header
                    
                    VStack{
                        HStack{
                            Text("Receipt Collections")
                                .foregroundStyle(.primary)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.gray)
                                .font(.system(size: 20))
                            
                            Text("Private")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(4)
                    .padding(.horizontal,4)
                    //Collection View
                    ScrollView{
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10.0)
                                    .foregroundColor(Color.black.opacity(0.15))
                                    .frame( height: 250, alignment: .center)
                                    .padding(.horizontal,4)
                                VStack{
                                    HStack(spacing: 4, content: {
                                        //For each picture rows
                                        ForEach(1..<6) { x in
                                            CollectionsView(day: x)
                                        }
                                    })
                                    HStack(spacing: 4, content: {
                                        //For each picture rows
                                        ForEach(1..<6) { x  in
                                            
                                            CollectionsView(day: x + 6)
                                        }
                                        .padding(.top, -7)
                                    })
                                    //View Collections Button
                                    VStack{
                                        Button {
                                            print("View Collections")
                                        } label: {
                                            Text("View Collection")
                                        }
                                        .buttonStyle(.bordered)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .tint(.black.opacity(0.9))
                                        .border(Color.blue, width: 2)
                                    }.padding(7)
                                }
                            }
                        }
                        Spacer()
                    }   .padding(.horizontal)
                }
                .background(Color.black.opacity(0.05))
            }
          

        }
        
    }
}

