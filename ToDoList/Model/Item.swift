//
//  Data.swift
//  ToDoList
//
//  Created by Gabriel Lorincz on 02/05/2018.
//  Copyright © 2018 Gabriel Lorincz. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
   // @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
