//
//  Item.swift
//  Todoie
//
//  Created by Thomas Prezioso on 12/11/18.
//  Copyright © 2018 Thomas Prezioso. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
