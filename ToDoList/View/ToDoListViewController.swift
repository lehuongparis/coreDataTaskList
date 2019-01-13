//
//  ToDoListView.swift
//  ToDoList
//
//  Created by AMIMOBILE on 08/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController {
    
    var tasks = Task.fetchAll()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = Task.fetchAll()
        tableView.reloadData()
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        alertAddTask()
    }
    
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        Task.deleteAll()
        self.tasks = Task.fetchAll()
        self.tableView.reloadData()
    }

    private func alertAddTask() {
        let alert = UIAlertController(title: nil, message: "Add New Task", preferredStyle: .alert)
        alert.addTextField { (textFieldTask) in
            textFieldTask.placeholder = "Task"
        }
        
        let saveAdd = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textField = alert.textFields?.first, let taskName = textField.text else { return }
            let task = Task(context: AppDelegate.viewContext)
            task.name = taskName
            self.tasks.append(task)
            try? AppDelegate.viewContext.save()
            self.tasks = Task.fetchAll()
            self.tableView.reloadData()
        }
        alert.addAction(saveAdd)
        present(alert, animated: true)
    }
}
    
extension ToDoListViewController: UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some tasks in the list"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tasks.isEmpty ? 200 : 0
    }
}
