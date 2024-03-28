//
//  EditProfileView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/25/24.
//

import SwiftUI

struct EditProfile: View {
    @State var width = UIScreen.main.bounds.width
    @State private var userFullName: String = ""
    @State private var  userName: String = ""
    @State private var userEmail: String = ""
    @State private var  location: String = ""
    @State private var bio: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color.clear
                        .ignoresSafeArea()
                    VStack {
                            Spacer()
                    }
                    VStack {
                        VStack{
                            ScrollView{
                           
                                Image("boys")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 120, height: 120)
                                VStack{
                                    ZStack{
                                        Circle()
                                            .frame(width: 31, height: 31)
                                        Circle()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(.white)
                                        Image(systemName: "camera.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 29, height: 29)
                                            .foregroundStyle(.black)
                                    }
                                }
                                .padding(.leading, 90)
                                .padding(.top, 90)
                            }
                            .padding(10.0)
                        }
                        VStack{
                        
                                TextField("Full Name", text: $userFullName)
                                    .font(.title2)
                                    .fontDesign(.serif)
                                    .textFieldStyle(.automatic)
                                    .padding(.horizontal)
                                    .padding(.bottom,10)
                                    .textFieldStyle(.automatic)
                                    .foregroundStyle(.secondary)
                                Divider()
                                TextField("User Name, @someName1234", text: $userName)
                                    .font(.title2)
                                    .fontDesign(.serif)
                                    .textFieldStyle(.automatic)
                                    .foregroundStyle(.secondary)
                                    .keyboardType(.emailAddress)
                                    .padding(.horizontal)
                                    .padding(.bottom,15)
                                    .textFieldStyle(.automatic)
                                
                                Text("Bio")
                                    .font(.title3)
                                    .fontDesign(.serif)
                                    .foregroundStyle(.secondary)
                                    TextEditor(text: $bio)
                                        .textEditorStyle(.automatic)
                                        .foregroundStyle(.secondary)
                                        .border(Color.secondary, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                        .frame(width: width * 0.96, height: 100)
                                        .font(.title2)
                                        .fontDesign(.serif)
                                        .foregroundStyle(.secondary)
                                        .padding(.bottom,15)
                                    
                                    TextField("Email Address", text: $userEmail)
                                        .font(.title2)
                                        .fontDesign(.serif)
                                        .textFieldStyle(.automatic)
                                        .foregroundStyle(.secondary)
                                        .keyboardType(.emailAddress)
                                        .padding(.horizontal)
                                        .padding(.bottom,10)
                                        .textFieldStyle(.automatic)
                                    Divider()
                                    TimeZoneView()
                                        .font(.title2)
                                        .fontDesign(.serif)
                                        .padding(.horizontal)
                                        .frame(width: width * 0.96)
                                     
                                    Divider()
                            }
                            Spacer()
                        }
                        .frame(width: width * 0.96)
                    }
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                HapticManager.notification(type: .success)
                            } label: {
                                Text("Save")
                            }
                        }
                    }
                }
            }
            .frame(width: width * 0.86)
        }
    }


#Preview {
    EditProfile()
}
