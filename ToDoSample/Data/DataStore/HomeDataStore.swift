//
//  HomeDataStore.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol HomeDataStore {
    func getToDoEntity() -> Observable<[ToDoEntity]>
    func saveToDoEntity(_ entity: ToDoEntity) -> Observable<Void>
}

struct HomeDataStoreImpl: HomeDataStore {
    
    func getToDoEntity() -> Observable<[ToDoEntity]> {
        return Observable.create { observer in
            do {
                let realm = try Realm()
                
                let list = realm.objects(ToDoEntity.self)
                    .reduce(into: [ToDoEntity]()) { (list, item) in
                        list.append(item)
                    }
                
                observer.onNext(list)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func saveToDoEntity(_ entity: ToDoEntity) -> Observable<Void> {
        return Observable.create { observer in
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.add(entity)
                }
                
                observer.onNext(())
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
