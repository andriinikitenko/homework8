//
//  TodoListViewController.swift
//  Todo-List
//
//  Created by Andrii Nikitenko on 11.12.16.
//  Copyright © 2016 Andrii Nikitenko. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dayTimePeriodFormatter = DateFormatter()
    @IBOutlet weak var tableView: UITableView!
    var tuskArr = [Tusk]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelectionDuringEditing = false;
        dayTimePeriodFormatter.dateFormat = "d:MMM:y:HH:mm"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tuskArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! TaskCell
        let task = tuskArr[indexPath.row]
        if task.complited {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        cell.label.text = task.taskText
        cell.dateLable.text = dayTimePeriodFormatter.string(from: task.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tuskArr[indexPath.row].complited = !tuskArr[indexPath.row].complited
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             tuskArr.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
    @IBAction func sortInTouch(_ sender: Any) {
        let alertControler = UIAlertController(title: "Sorting by: ", message: nil, preferredStyle: .actionSheet)
        
        let alerAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let sortDateAction = UIAlertAction(title: "Sort by date", style: .default, handler: {(alertController) in
            self.tuskArr.sort(by: { (task1, task2) -> Bool in
                return task1.date.compare(task2.date) == .orderedDescending
            })
            self.tableView.reloadData()
        })
        let sortTextAction = UIAlertAction(title: "Sort by name", style: .default, handler: {(alertController) in
            self.tuskArr.sort(by: { (task1, task2) -> Bool in
                return task1.taskText.localizedCaseInsensitiveCompare(task2.taskText) == .orderedAscending
            })
            self.tableView.reloadData()
        })

        alertControler.addAction(alerAction)
        alertControler.addAction(sortDateAction)
        alertControler.addAction(sortTextAction)


        self.present(alertControler, animated: true, completion: nil)
    }
    
    

    // Action for Sort
    // UIAlerController, type = ActionSheet, prestnt
    // tuskArr.sort({}), tableView.reload 
}
