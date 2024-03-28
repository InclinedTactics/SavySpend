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
    @State private var name: String = ""
    @State private var userName: String = ""
    @State private var userEmail: String = ""
    /// App Lock Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    @Environment(\.modelContext) private var context
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
    @Environment(\.dismiss) private var dismiss
   
    var body: some View {
        NavigationStack {
            ///profile row
            
            Form {
                
                //MARK:  USER DETAILS
                Section("User Details"){
                    NavigationLink(destination: ProfileView(name: name, userName: userName, userEmail: userEmail)) {
                        HStack{
                            SettingRow(iconName: "camera.circle", iconColor: appTint)
                            Text("Receipt Collection")
                                .fontDesign(.serif)
                                .foregroundStyle(.primary)
                        }
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
                                Text("Contact Us")
                                    .fontDesign(.serif)
                                    .foregroundStyle(.primary)
                            }
                        }
                        NavigationLink(destination: HelpView()) {
                            HStack{
                                SettingRow(iconName: "questionmark.circle", iconColor: .red)
                                Text("Help?")
                                    .fontDesign(.serif)
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                    //MARK:  HELP CENTER
                    Section("Import & Export") {
                        
                        Button {
                            exportTransactions()
                        } label: {
                            HStack{
                                SettingRow(iconName: "square.and.arrow.up", iconColor: .colorBlue1)
                                Text("Export")
                                    .fontDesign(.serif)
                                    .foregroundStyle(appTint)
                            }
                        }
                        Button {
                            presentFilePicker.toggle()
                        } label: {
                            HStack{
                                SettingRow(iconName: "square.and.arrow.down", iconColor: .colorODGreen)
                                Text("Import")
                                    .fontDesign(.serif)
                                    .foregroundStyle(appTint)
                            }
                        }
                        
                    }
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            /// For Exporting Expneses as JSON File
            .sheet(isPresented: $presentShareSheet) {
                deleteTempFile()
            } content: {
                CustomShareSheet(url: $shareURL)
            }
            /// File Importer (For Selecting JSON File From Files App)
            .fileImporter(isPresented: $presentFilePicker, allowedContentTypes: [.json]) { result in
                switch result {
                case .success(let url):
                    if url.startAccessingSecurityScopedResource() {
                        importJSON(url)
                    } else {
                        alertMessage = "Failed to access the File due to security reasons!"
                        showAlert.toggle()
                    }
                case .failure(let failure):
                    alertMessage = failure.localizedDescription
                    showAlert.toggle()
                }
            }
            /// Alert View
            .alert(alertMessage, isPresented: $showAlert) {  }
            /// Loading View (Displaying when any Heavy task is happening in the background)
            .overlay {
                LoadingView(show: $isLoading)
            }
            .toolbar(isLoading ? .hidden : .visible, for: .tabBar)
            .onChange(of: enableNotifications, initial: true) { _, newValue in
                if newValue {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { status, _ in
                        enableNotifications = status
                    }
                } else {
                    removeAllPendingNotifications()
                }
            }
        }
    
    /// Importing JSON File and Adding to SwiftData
    func importJSON(_ url: URL) {
        isLoading = true
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1) {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let transactions = try decoder.decode([Transaction].self, from: jsonData)
                
                DispatchQueue.main.async {
                    for transaction in transactions {
                        context.insert(transaction)
                    }
                    isLoading = false
                    alertMessage = "File Imported Successfully!"
                    showAlert.toggle()
                    /// Updating Widgets
                    WidgetCenter.shared.reloadAllTimelines()
                }
            } catch {
                /// DO ACTION
                displayAlert(error)
            }
        }
    }
    
    /// Exporting SwiftData to JSON File
    func exportTransactions() {
        isLoading = true
        Task.detached(priority: .high) {
            try? await Task.sleep(for: .seconds(1))
            /// Step 1:
            /// Fetching All Transactions from SwiftData
            if let transactions = try? context.fetch(.init(sortBy: [
                SortDescriptor(\Transaction.dateAdded, order: .reverse)
            ])) {
                /// Step 2:
                /// Converting Items to JSON String File
                let jsonData = try JSONEncoder().encode(transactions)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    /// Saving into Temporary Document And Sharing it Via ShareSheet
                    let tempURL = URL(filePath: NSTemporaryDirectory())
                    let pathURL = tempURL.appending(component: "My Expenses\(Date().formatted(date: .complete, time: .omitted)).json")
                    try jsonString.write(to: pathURL, atomically: true, encoding: .utf8)
                    /// Saved Successfully
                    await MainActor.run {
                        shareURL = pathURL
                        presentShareSheet.toggle()
                        isLoading = false
                    }
                }
            } else {
                await MainActor.run {
                    isLoading = false
                    alertMessage = "Error on Exporting"
                    showAlert.toggle()
                }
            }
        }
    }
    
    func deleteTempFile() {
        do {
            try FileManager.default.removeItem(at: shareURL)
            print("Removed Temp JSON File")
        } catch {
            displayAlert(error)
        }
    }
    
    /// Displays alert from background thread
    func displayAlert(_ error: Error) {
        DispatchQueue.main.async {
            alertMessage = error.localizedDescription
            showAlert.toggle()
            isLoading = false
        }
    }
    /// Remove All Pending Notifications
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
  
    //MARK:  SETTINGS ROW
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


