//
//  SettingsView.swift
//  SavySpend
//
//  Created by J. DeWeese on 3/19/24.
//

import SwiftUI
import WidgetKit
import SwiftData
import UserNotifications



struct SettingsView: View {
    /// User Properties
    @AppStorage("UserName") private var userName: String = ""
    @AppStorage("UserEmail") private var userEmail: String = ""
    /// App Lock Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    //    @Environment(\.modelContext) private var context
    /// App Theme Properties
    @State private var changeTheme: Bool = false
    @Environment(\.colorScheme) private var scheme
    //    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    /// Notification Properties
    @AppStorage("enableNotifications") private var enableNotifications: Bool = false
    @AppStorage("notificationAccess") private var isNotificationAccessGiven: NotificationState = .notDetermined
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
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
            ///profile row
            Form {
                //MARK:  PROFILE PIC
                Button {
                    
                } label: {
                    SettingsHeaderView()
                }
                
                //MARK:  USER DETAILS
                Section("User Details"){
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.orange)
                                .frame(width: 35, height: 35)
                            Image(systemName: "person.circle")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                        TextField("User Name", text: $userName)
                            .textFieldStyle(.roundedBorder)
                            .fontDesign(.serif)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                    }
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.orange)
                                .frame(width: 35, height: 35)
                            Image(systemName: "envelope.circle")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                        TextField("User Email", text: $userEmail)
                            .fontDesign(.serif)
                            .padding(.horizontal)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                }
                //MARK:  NOTIFICATIONS
                Section {
                    Toggle(isOn: $enableNotifications) {
                        HStack{
                            SettingRow(iconName: "bell", iconColor: .blue)
                            Text("Notifications")
                                .fontDesign(.serif)
                        }
                    }
                    .disabled(isNotificationAccessGiven == .denied)
                } header: {
                    Text("Notifications")
                } footer: {
                    switch isNotificationAccessGiven {
                    case .notDetermined:
                        Text("Enable notifications for scheduled transactions.")
                            .fontDesign(.serif)
                            .foregroundStyle(.black.opacity(0.4))
                    case .approved:
                        Text(enableNotifications ? "Warning, disabling will cancel all the future notifications." : "You will be notified about up-coming scheduled transactiuons.")
                    case .denied:
                        Button("Please visit settings to provide the Notification Access!") {
                            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                                openURL(settingURL)
                            }
                        }
                        .font(.caption2)
                    }
                }
                //MARK:  APP SETTINGS
                Section("App Settings") {
                    NavigationLink(destination: ThemeView()) {
                        HStack{
                            SettingRow(iconName: "paintbrush", iconColor: .purple)
                            Text("Theme Settings")
                                .fontDesign(.serif)
                                .foregroundStyle(.primary)
                        }
                    }
                }
                //MARK:  PRIVACY AND SECURITY
                Section("Privacy & Security") {
                    HStack{
                        SettingRow(iconName: "faceid", iconColor: .green)
                        Toggle("Face ID", isOn: $isAppLockEnabled)
                        if isAppLockEnabled {
                            Toggle("Lock When App Goes Background", isOn: $lockWhenAppGoesBackground)
                        }
                    }
                }
                //MARK:  HELP CENTER
                Section("Help Center") {
                    NavigationLink(destination: AboutUsView()) {
                        HStack{
                            SettingRow(iconName: "info.circle", iconColor: .orange)
                            Text("About Us")
                                .fontDesign(.serif)
                                .foregroundStyle(.primary)
                        }
                    }
                    NavigationLink(destination: AboutUsView()) {
                        HStack{
                            SettingRow(iconName: "questionmark.circle", iconColor: .red)
                            Text("Help?")
                                .fontDesign(.serif)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
    }
}
 #Preview {
    SettingsView()
}
    struct SettingRow: View {
        let iconName: String
        let iconColor: Color
        
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(iconColor)
                    .frame(width: 35, height: 35)
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundStyle(.white)
            }
            
        }
    }
    

