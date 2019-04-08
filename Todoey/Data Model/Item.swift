//
//  Item.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 4/8/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
   @objc dynamic var title :String = ""
   @objc dynamic var done :Bool = false
                                                                //items -> at Category class as listOfitems
  let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
