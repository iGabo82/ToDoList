//
//  ViewController.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 25/04/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import UIKit

class ToDoVC: UITableViewController {

    let itemArray = ["Make Love", "Call Mother", "Save The World"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    //MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    

    

}

