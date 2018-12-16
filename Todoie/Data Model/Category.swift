//
//  Category.swift
//  Todoie
//
//  Created by Thomas Prezioso on 12/11/18.
//  Copyright © 2018 Thomas Prezioso. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let items = List<Item>()
}
