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
    func saveToDoEntity(_ title: String) -> Observable<Void>
    func updateToDoEntity(_ id: Int) -> Observable<Void>
}

struct HomeRepositoryImpl: HomeRepository {
    
    private let dataStore: HomeDataStore
    
    init(dataStore: HomeDataStore) {
        self.dataStore = dataStore
    }
    
    func getToDoEntity() -> Observable<[ToDoEntity]> {
        return dataStore.getToDoEntity()
    }
    
    func saveToDoEntity(_ title: String) -> Observable<Void> {
        return dataStore.saveToDoEntity(title)
    }
    
    func updateToDoEntity(_ id: Int) -> Observable<Void> {
        return dataStore.updateToDoEntity(id)
    }
}
