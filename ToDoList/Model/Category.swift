//
//  Category.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 02/05/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()

}
