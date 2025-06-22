//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Vadym on 22.06.2025.
//


import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
