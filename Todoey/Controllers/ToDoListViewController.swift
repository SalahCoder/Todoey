//
//  ViewController.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 3/7/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    let realm = try! Realm()
    var toDoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet{
            loadItem()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
         //retreiving data useing userDefaults
//        loadItem()
    }
    //MARK - TableView datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row]{
               cell.textLabel?.text = item.title
            //Ternary Operator FORMAT ==>
            //value = condition ? valueIfTrue : valueIfFalse
            //        cell.accessoryType = item.done ? .checkmark : .none //use can delete item.done==true
            //the above line same as the beloew but in shorter way -- use it always
            //        if item.done == true{
            //            cell.accessoryType = .checkmark
            //        }else{
            //            cell.accessoryType = .none
            //        }
        }else{
            cell.textLabel?.text = "No Items Added Yet"
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    //MARK - tableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print (itemArray[indexPath.row])
        //for deleting items from context and itemArray
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
//          toDoItems[indexPath.row].done = !toDoItems[indexPath.row].done
        
//          saveItem()

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK - add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var  textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) -> Void in
            //what will happen
          
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                    let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("saving data error\(error)")
                }
            }
            self.tableView.reloadData()
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todoey"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    func loadItem(){
//        toDoItems = realm.objects(Item.self)
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

//extension ToDoListViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let requset : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        let sortDescroptor = NSSortDescriptor(key: "title", ascending: true)
//        requset.sortDescriptors = [sortDescroptor]
//        loadItem(with: requset , predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItem()
//        }
//        DispatchQueue.main.async {
//            searchBar.resignFirstResponder()
//        }
//    }
//}
//
}
