//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by AMIMOBILE on 10/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.


import XCTest
import CoreData
@testable import ToDoList

class ToDoListTests: XCTestCase {
    
    //MARK: - Vars
    let viewContext: NSManagedObjectContext = AppDelegate.persistentContainer.newBackgroundContext()
    
    //MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        Task.deleteAll()
        super.tearDown()
    }
    
    //MARK: - Helper Methods
    private func insertNewTask(into managedObjectContext: NSManagedObjectContext) {
        let newTask = Task(context: managedObjectContext)
        newTask.name = "Task's name"
    }
    
    //MARK: - Unit Tests
    func testInsertManyTasksInPersistentContainer() {
        for _ in 0 ..< 100000 {
            insertNewTask(into: viewContext)
        }
        XCTAssertNoThrow(try viewContext.save())
    }
    
    func testDeleteAllToDoItemsInPersistentContainer() {
        Task.deleteAll()
        XCTAssertEqual(Task.fetchAll(), [])
    }
}
