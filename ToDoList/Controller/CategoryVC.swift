//
//  CategoryVC.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 26/04/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {

    var categoryArray = [Category]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }


    //MARK: - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
   
 
    
    //MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        saveCategory()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    //MARK: - Data Manipulating Method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            let newItem = Category(context: context)
            newItem.name = textField.text!
            self.categoryArray.append(newItem)
            
            self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
            
        }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveCategory() {
        do { try context.save()
        } catch {
            print("Error with saving data \(error)!")
        }
        
        tableView.reloadData()
    }
    
    func loadCategory() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetching data \(error)!")
        }
       
        tableView.reloadData()
    }
    
    
}
    
    

    


