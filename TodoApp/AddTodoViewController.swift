//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by Shengjie Mao on 11/20/23.
//

import UIKit
import RealmSwift

class AddTodoViewController: UIViewController {
    
    lazy var db = try! Realm()

    @IBOutlet weak var txtTodo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveToDoAction(_ sender: Any) {
        do {
            guard let todoTxt = txtTodo.text else {return}
            let todo = ToDoClass()
            todo.todo = todoTxt
            // check where the data sent to
            print( db.configuration.fileURL)
            try db.write{
                db.add(todo, update: .modified)
            }
            self.navigationController?.popViewController(animated: true)
        }catch let error as NSError{
            print("Error in writing to Realm DB: \(error.localizedDescription)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
