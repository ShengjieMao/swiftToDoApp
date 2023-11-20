//
//  ViewController.swift
//  TodoApp
//
//  Created by Shengjie Mao on 11/20/23.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    let arr = ["Test", "Code"]
    var todos: [ToDoClass] = [ToDoClass]()
    lazy var db = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        getDataFromDB()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].todo
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromDB(todos[indexPath.row])
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func getDataFromDB() {
        do {
            let todosDB = db.objects(ToDoClass.self)
            print(todosDB)
            todos = [ToDoClass]()
            for todo in todosDB{
                todos.append(todo)
            }
            tblView.reloadData()
            
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteFromDB(_ todo : ToDoClass){
        do {
            try db.write{
                db.delete(todo)
            }
        }catch let error as NSError{
            print("Error in writing to Realm DB: \(error.localizedDescription)")
        }
    }
}

