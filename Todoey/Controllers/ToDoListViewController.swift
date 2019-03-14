//
//  ViewController.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 3/7/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

   var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "go to the shop"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "think more"
        itemArray.append(newItem2)
        
        //retreiving data useing userDefaults
        if let items = defaults.array(forKey: "TodoListAraay") as? [Item] {
            itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK - TableView datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
           cell.textLabel?.text = item.title
        
        //Ternary Operator FORMAT ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none //use can delete item.done==true
        //the above line same as the beloew but in shorter way -- use it always
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK - tableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print (itemArray[indexPath.row])
       
          itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        the above line same as the beleow but on the shorter way --- use it always
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else{
//            itemArray[indexPath.row].done = false
//        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK - add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var  textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen
            let newItem = Item()
            newItem.title = textField.text!
           self.itemArray.append(newItem)
           
            self.defaults.set(self.itemArray, forKey: "TodoListAraay")
            
           self.tableView.reloadData()
            
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todoey"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    


}

