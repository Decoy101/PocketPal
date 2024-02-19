//
//  PocketPalApp.swift
//  PocketPal
//
//  Created by Aman Gupta on 19/02/24.
//

import SwiftUI

@main
struct PocketPalApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            DashboardView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
