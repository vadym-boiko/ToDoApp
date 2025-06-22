//
//  PersistenceController.swift
//  ToDoApp
//
//  Created by Vadym on 22.06.2025.
//

import Foundation

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TaskModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
