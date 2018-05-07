//
//  CategoryVC.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 26/04/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryVC: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        tableView.rowHeight = 80.0
        
        loadCategory()
    }
   

    //MARK: - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
       
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
 
    
    //MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
//we dont need it, because realm is auto updated            self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
        }
    
  //MARK: - Data Manipulating Method
    
    func save(category: Category) {
        do { try realm.write {
            realm.add(category)
            }
        } catch {
            print("Error with saving data \(error)!")
        }
        
        tableView.reloadData()
    }

    func loadCategory() {
        
        categoryArray = realm.objects(Category.self)
       
         tableView.reloadData()
    }

}


//MARK: - SwipeTableView Delegat

extension CategoryVC : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let categoryForDeletion = self.categoryArray?[indexPath.row] {
                do{
                    try self.realm.write {
                        self.realm.delete(categoryForDeletion)
                    }
                }catch{
                    print("Error deleting categories \(error)")
                }
            }
            
    }
    
        // customize the action appearance
        deleteAction.image = UIImage(named: "Trash")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
 
}

