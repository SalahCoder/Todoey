
//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 3/31/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()
    var categories : Results<Category>!
    override func viewDidLoad() {
        super.viewDidLoad()
//        print (Realm.Configuration.defaultConfiguration.fileURL)
        //path for storing database
//         print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategory()
        tableView.rowHeight = 80.0
        
    }
   
    //MARK: - tableView DataSource Methodes
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1 //if nil return 1 --if NOT return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        return cell
    }
    
    //MARK: - delete data by swiping cell
    override func updateModel(at indexPath: IndexPath){
       
        if let item1 = self.categories?[indexPath.row]{
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
   
    
    
    //MARK: - tableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Add Button Pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       var textField = UITextField()
       let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Add Category", style: .default) { (action) in
            
       let newCategory = Category()
           newCategory.name = textField.text!
           self.save(category: newCategory)
           self.tableView.reloadData()

        })
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "add new category"
            textField = alertTextField
        }
        self.present(alert ,animated: true , completion: nil)
    }
    
    
    //MARK: - TableView Manipulation Methods
    func save(category :Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("save category error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
       categories = realm.objects(Category.self)
        tableView.reloadData()
    }
}
