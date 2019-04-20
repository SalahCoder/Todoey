//
//  ViewController.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 3/7/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: SwipeTableViewController {
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
    }
    //MARK - TableView datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = toDoItems?[indexPath.row]{
               cell.textLabel?.text = item.title
               cell.accessoryType = item.done ? .checkmark : .none //use can delete item.done==true
          
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

      if let item = toDoItems?[indexPath.row]{
            do{
                try realm.write {
                   
                    //for updating items using realm
                    item.done = !item.done
                }
            }catch{
                print("updating error \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - deleting cell from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let item1 = toDoItems?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(item1)
                }
            }catch {
                print ("deleting category error")
            }
            // tableView.reloadData()
        }
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
                        newItem.dateCreated = Date()
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
}

extension ToDoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
          toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
          tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0{
                loadItem()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
