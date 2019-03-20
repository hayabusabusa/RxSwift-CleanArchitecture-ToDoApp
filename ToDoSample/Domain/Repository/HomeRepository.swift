//
//  HomeRepository.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeRepository {
    func getToDoEntity() -> Observable<[ToDoEntity]>
    func saveToDoEntity(_ entity: ToDoEntity) -> Observable<Void>
}

struct HomeRepositoryImpl: HomeRepository {
    
    private let dataStore: HomeDataStore
    
    init(dataStore: HomeDataStore) {
        self.dataStore = dataStore
    }
    
    func getToDoEntity() -> Observable<[ToDoEntity]> {
        return dataStore.getToDoEntity()
    }
    
    func saveToDoEntity(_ entity: ToDoEntity) -> Observable<Void> {
        return dataStore.saveToDoEntity(entity)
    }
}
