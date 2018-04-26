//
//  ViewController.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 25/04/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import UIKit
import CoreData

class ToDoVC: UITableViewController {

    var itemArray = [Items]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
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
        saveItems()
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: - Set AddItemButton Method
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happens when the user click on it
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newItem = Items(context: context)
            
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
           
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
   
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
        } catch {
            print("Error saving context \(error)!")
        }
    
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        do{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)!")
        }
    }

}

