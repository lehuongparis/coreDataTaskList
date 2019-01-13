//
//  Task.swift
//  ToDoList
//
//  Created by AMIMOBILE on 10/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let tasks = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return tasks
    }
    
    static func deleteAll() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Task.fetchRequest())
        let _ = try? AppDelegate.viewContext.execute(deleteRequest)
    }
}

