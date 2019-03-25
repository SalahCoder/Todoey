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
  
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //retreiving data useing userDefaults
            loadItem()
       
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
        
          saveItem()

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
           
           self.saveItem()

           self.tableView.reloadData()
            
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todoey"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem (){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }catch{
            print ("error encoding item Array \(error)")
        }
    }
    func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print ("error encoding item Array \(error)")
            }
        }
    }
    


}

