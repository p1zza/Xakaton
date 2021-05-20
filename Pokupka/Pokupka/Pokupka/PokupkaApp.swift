//
//  PokupkaApp.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 12.05.2021.
//

import SwiftUI

@main
struct PokupkaApp: App {
    let user = UserData()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(user)
        }
    }
}
