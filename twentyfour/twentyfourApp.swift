//
//  twentyfourApp.swift
//  twentyfour
//
//  Created by Sebastian Fox on 09.03.21.
//

import SwiftUI

@main
struct twentyfourApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
