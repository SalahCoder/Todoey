//
//  ViewController.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 3/7/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

   var itemArray = [Item]()
//    var selectedCategory : Category? {
//        didSet{
////            loadItem()
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
         //retreiving data useing userDefaults
//        loadItem()
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
        //for deleting items from context and itemArray
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
          itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//          saveItem()

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK - add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var  textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen
          
//       let newItem = Item(context: self.context)
//           newItem.title = textField.text!
//           newItem.done = false
//           newItem.parentCategory = self.selectedCategory
//           self.itemArray.append(newItem)
//           self.saveItem()
//           self.tableView.reloadData()
            
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todoey"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
//
//    func saveItem (){
//
//        do{
////            try context.save()
//        }catch{
//            print ("error saving context \(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    
//    func loadItem(with requset : NSFetchRequest<Item> = Item.fetchRequest() , predicate:NSPredicate? = nil){
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate{
//            requset.predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[categoryPredicate , additionalPredicate])
//        }else{
//            requset.predicate = categoryPredicate
//        }
    
    
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate , predicate!])
//        requset.predicate = compoundPredicate
//
//        do{
//           itemArray = try context.fetch(requset)
//        }catch{
//            print ("Error fetching data from context \(error)")
//        }
//        tableView.reloadData()
//    }


//}
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
