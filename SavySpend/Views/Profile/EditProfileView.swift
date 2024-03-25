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
        VStack {
            
            ZStack {
                Color.black.opacity(0.15)
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        HStack {
                            Text("Cancel")
                                .foregroundStyle(.white)
                                .fontDesign(.serif)
                                .shadow(color:.black, radius: 1, x: 1, y: 1)
                            
                            Spacer()
                            Text("Save")
                                .foregroundStyle(.white)
                                .fontDesign(.serif)
                                .shadow(color:.black, radius: 1, x: 1, y: 1)
                        }
                        .padding(.horizontal, width * 0.05)
                        Text("Edit Profile")
                            .foregroundStyle(.white)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            .shadow(color:.black, radius: 1, x: 1, y: 1)
                    }
                    HStack{
                        Spacer()
                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(width: width * 0.95, height: 0.7)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                VStack {
                    
                    VStack{
                        ZStack {
                            Image("joe")
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
                    }
                    .padding(50)
                    VStack{
                        ScrollView{
                            TextField("Full Name", text: $userFullName)
                                .font(.title2)
                                .fontDesign(.serif)
                                .textFieldStyle(.automatic)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal)
                                .padding(.bottom,10)
                            Divider()
                            TextField("User Name, @someName1234", text: $userName)
                                .font(.title2)
                                .fontDesign(.serif)
                                .textFieldStyle(.automatic)
                                .foregroundStyle(.secondary)
                                .keyboardType(.emailAddress)
                                .padding(.horizontal)
                                .padding(.bottom,15)
                            
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
                                Divider()
                                TextField("📍 Location", text: $location)
                                    .font(.title2)
                                    .fontDesign(.serif)
                                    .textFieldStyle(.automatic)
                                    .foregroundStyle(.secondary)
                                    .keyboardType(.emailAddress)
                                    .padding(.horizontal)
                                    .padding(4)
                                Divider()
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(1)
        .padding(.horizontal, 20)
        
    }
}

#Preview {
    EditProfile()
}
