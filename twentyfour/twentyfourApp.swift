//
//  twentyfourApp.swift
//  twentyfour
//
//  Created by Sebastian Fox on 09.03.21.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("Colors application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    return true
  }
}

@main
struct twentyfourApp: App {
    let persistenceController = PersistenceController.shared
    var usersViewModel: UsersViewModel
    var appSettingsViewModel: AppSettingsViewModel
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
      FirebaseApp.configure()
        usersViewModel = UsersViewModel()
        appSettingsViewModel = AppSettingsViewModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(usersViewModel)
                .environmentObject(appSettingsViewModel)
        }
    }
}
