//
//  ViewController.swift
//  Done
//
//  Created by Christian Skorobogatow on 14/12/2019.
//  Copyright © 2019 Christian Skorobogatow. All rights reserved.
//

import UIKit

protocol AddTask {
    func addTask(name: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ChangeButton {
    
    var tasks: [Task] = []
    
    @IBAction func addAction(_ sender: Any) {
        if taskNameOutlet.text != "" {
            addTask(name: taskNameOutlet.text!)
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
            taskNameOutlet.resignFirstResponder()
            taskNameOutlet.text = ""
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskNameOutlet: UITextField!
    
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        self.tableView.separatorStyle = .none
        
        //Listen for keyboard events
       NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

    }
    
    deinit {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        if tasks[indexPath.row].checked {
            let checkFilled = UIImage(named: "box-checked")
            cell.checkBoxOutlet.setBackgroundImage(checkFilled, for: UIControl.State.normal)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            } else {
            let checkEmpty = UIImage(named: "box-unchecked")
            cell.checkBoxOutlet.setBackgroundImage(checkEmpty ,for: UIControl.State.normal)
            }
        
            cell.delegate = self
            cell.indexP = indexPath.row
            cell.tasks = tasks
            
            return cell
         }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
            }
    }

    func addTask(name: String) {
        tasks.append(Task(name: name))
        tableView.reloadData()
    }
    
    func changeButton(checked: Bool, index: Int) {
        tasks[index].checked = checked
        tableView.reloadData()
    }
    
    //This to identify the size of the keyboard and move the View accordingly
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue) ")
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else {
             view.frame.origin.y = 0
        }
    }

    
}

class Task {
    var name = ""
    var checked = false
    
    convenience init(name: String) {
    self.init()
    self.name = name
    }
}
