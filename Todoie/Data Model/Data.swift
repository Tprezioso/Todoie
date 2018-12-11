//
//  Data.swift
//  Todoie
//
//  Created by Thomas Prezioso on 12/10/18.
//  Copyright © 2018 Thomas Prezioso. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age: Int = 0
}
