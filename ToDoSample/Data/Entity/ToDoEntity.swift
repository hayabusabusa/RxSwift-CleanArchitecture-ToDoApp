//
//  ToDoEntity.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ToDoEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var state: Bool = false
    
    override static func primaryKey() -> String? { return "id" }
    
    convenience init(id: Int, title: String, state: Bool) {
        self.init()
        self.id = id
        self.title = title
        self.state = state
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
