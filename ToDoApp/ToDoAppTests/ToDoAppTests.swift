//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Vadym on 22.06.2025.
//

import XCTest
import CoreData
@testable import ToDoApp

final class ToDoAppTests: XCTestCase {
    var persistenceController: PersistenceController!
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        persistenceController = PersistenceController(inMemory: true)
        context = persistenceController.container.viewContext
    }

    func testAddTask() throws {
        let task = TaskEntity(context: context)
        task.title = "Test task"
        task.isDone = false

        try context.save()

        let request = TaskEntity.fetchRequest()
        let results = try context.fetch(request)

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.title, "Test task")
        XCTAssertFalse(results.first!.isDone)
    }

    func testToggleTaskCompletion() throws {
        let task = TaskEntity(context: context)
        task.title = "Another task"
        task.isDone = false

        try context.save()

        task.isDone = true
        try context.save()

        let request = TaskEntity.fetchRequest()
        let results = try context.fetch(request)

        XCTAssertTrue(results.first!.isDone)
    }

    func testDeleteTask() throws {
        let task = TaskEntity(context: context)
        task.title = "Temporary task"
        try context.save()

        context.delete(task)
        try context.save()

        let request = TaskEntity.fetchRequest()
        let results = try context.fetch(request)

        XCTAssertEqual(results.count, 0)
    }
}
