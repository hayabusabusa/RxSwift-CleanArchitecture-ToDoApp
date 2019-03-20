//
//  ToDoViewModel.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct ToDoViewModel {
    
    let id: Int
    let title: String
    let state: Bool
    
    init(_ entity: ToDoEntity) {
        id = entity.id
        title = entity.title
        state = entity.state
    }
}
