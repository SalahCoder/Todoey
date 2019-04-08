//
//  Category.swift
//  Todoey
//
//  Created by Salaheldeen Khalifa on 4/8/19.
//  Copyright © 2019 Salaheldeen Khalifah. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
   @objc dynamic var name:String = ""
    
    let items = List<Item>()
}
