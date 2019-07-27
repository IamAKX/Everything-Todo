//
//  ViewController.swift
//  Everything Todo
//
//  Created by Akash Giri on 26/07/19.
//  Copyright © 2019 Akash Giri. All rights reserved.
//

import UIKit
import Disk

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todoTableView: UITableView!
    
//    var todos: [TodoModel] = [TodoModel(data: "Learn Swift", isChecked: true), TodoModel(data: "Develop nice IOS app", isChecked: false), TodoModel(data: "Stay happy", isChecked: false)]
    
    var todos = [TodoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todoTableView.delegate = self
        todoTableView.dataSource = self
        getTodo()
    }

    @IBAction func addTodo(_ sender: Any) {
        let todoAlert = UIAlertController(title: "Add new todo task", message: "", preferredStyle: .alert)
        todoAlert.addTextField()
        
        let addTodoAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newTodo = todoAlert.textFields![0]
            self.todos.append(TodoModel(data: newTodo.text!, isChecked: false))
            self.todoTableView.reloadData()
            self.saveTodo()
        }
        
        let cancelTodoAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        todoAlert.addAction(addTodoAction)
        todoAlert.addAction(cancelTodoAction)
        
        present(todoAlert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        
        if(todos[indexPath.row].isChecked == true)
            {
                cell.todoLabel.attributedText = strikeThroughText(todos[indexPath.row].data!)
        }
        else
        {
            cell.todoLabel.text = todos[indexPath.row].data
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        cell.contentView.backgroundColor = UIColor.white
        
        if(todos[indexPath.row].isChecked == false){
            cell.todoLabel.attributedText = strikeThroughText(todos[indexPath.row].data!)
//            cell.isChecked = true
            todos[indexPath.row].isChecked = true
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = cell.transform.scaledBy(x: 1.5, y: 1.5)
            }, completion: {
                (success) in
                UIView.animate(withDuration: 0.3,delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: nil)
            })
        }
        else
        {
            cell.todoLabel.attributedText = nil
            cell.todoLabel.text = todos[indexPath.row].data!
//            cell.isChecked = false
            todos[indexPath.row].isChecked = false

        }
        
        saveTodo()
    }
    
    
    func strikeThroughText(_ text:String) -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete"){
            (action:UITableViewRowAction, indexPath:IndexPath) in
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }
    
    func saveTodo() {
        do{
        try Disk.save(todos, to: .caches, as: "todos.json")
        } catch let error as NSError{
            print(error)
        }
    }
    
    func getTodo() {
        do{
        todos = try Disk.retrieve("todos.json", from: .caches, as: [TodoModel].self)
        }catch let error as NSError{
            print(error)
            todos = []
        }
    }
}

