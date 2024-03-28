//
//  ThemeView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI
import WidgetKit
import SwiftData
import UserNotifications

struct ThemeView: View {
    /// User Properties
    @AppStorage("userName") private var userName: String = ""
    /// App Lock Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    @Environment(\.modelContext) private var context
    /// App Theme Properties
    @State private var changeTheme: Bool = false
    let rows = [GridItem(.fixed(27)), GridItem(.fixed(27)), GridItem(.fixed(27))]
    //    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    /// Notification Properties
    @AppStorage("enableNotifications") private var enableNotifications: Bool = false
    @AppStorage("notificationAccess") private var isNotificationAccessGiven: NotificationState = .notDetermined
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.colorScheme) private var scheme
    
    /// Import & Export Properties
    @State private var presentFilePicker: Bool = false
    @State private var presentShareSheet: Bool = false
    @State private var shareURL: URL = URL(string: "https://apple.com")!
    @State private var isLoading: Bool = false
    /// Alert Properties
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    var body: some View {
        NavigationStack {
            Divider()
                .padding()
            
            Section("App Tint") {
                VStack(alignment: .center){
                    Text("(Choose theme color)")
                        .font(.footnote)
                        .fontDesign(.serif)
                        .padding(.top, 20)
                        .foregroundStyle(appTint)
                  
                       LazyHGrid(rows: rows){
                            ForEach(tints) { tint in
                                Circle()
                                    .fill(tint.value.gradient)
                                    .frame(width: 25, height: 25)
                                    .overlay {
                                        if UIConstants.shared.appTint == tint.color {
                                            Circle()
                                                .stroke(.black, lineWidth: 2)
                                                .padding(5)
                                        }
                                    }
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        UserDefaults.standard.setValue(tint.color, forKey: "appTint")
                                        UIConstants.shared.appTint = tint.color
                                    }
                            }
                            
                        }
                            .padding(.horizontal, 5)
                            .background(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(.colorGray1)
                            .frame(width: 165, height: 140)
                }
                Section("Appearance") {
                    
                }
                .fontDesign(.serif)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                
                Spacer()
            }
            .fontDesign(.serif)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .navigationTitle("App Theme")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
}

#Preview {
    ThemeView()
}
