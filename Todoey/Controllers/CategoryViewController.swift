
//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 3/31/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        //path for storing database 
         print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategory()
        
    }
   
    //MARK: - tableView DataSource Methodes
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    
    //MARK: - tableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Add Button Pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       var textField = UITextField()
       let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Add Category", style: .default) { (action) in
            
       let newCategory = Category(context: self.context)
           newCategory.name = textField.text!
           self.categoryArray.append(newCategory)
           self.saveCategory()
           self.tableView.reloadData()

        })
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "add new category"
            textField = alertTextField
        }
        self.present(alert ,animated: true , completion: nil)
    }
    
    
    //MARK: - TableView Manipulation Methods
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print("save category error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        let requset : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            try categoryArray = context.fetch(requset)
        }catch{
            print ("fetching request error \(error)")
        }
        tableView.reloadData()
    }
}
