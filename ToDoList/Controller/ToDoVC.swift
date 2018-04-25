//
//  ViewController.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 25/04/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import UIKit

class ToDoVC: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Make Love"
        itemArray.append(newItem)
       
        let newItem2 = Item()
        newItem2.title = "Call Mother"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Save The World"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        itemArray = items
      }
    }


    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done ? .checkmark : .none
        /* TERNARY OPERATOR
         if item.done == true {
            cell.accessoryType = .checkmark
         }else {
            cell.accessoryType = .none
         }
        */
        
        return cell
    }
    

    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   print(itemArray[indexPath.row])
    
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        /*
         if itemArray[indexPath.row].done == false {
         itemArray[indexPath.row].done = true
         }else{
         itemArray[indexPath.row].done = false
         }
        */
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Set AddItemButton Method
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happens when the user click on it
            
            //  print("item was added")
            //  print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
           
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    

}

