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
    func saveToDoEntity(_ title: String) -> Observable<Void>
    func updateToDoEntity(_ id: Int) -> Observable<Void>
}

struct HomeDataStoreImpl: HomeDataStore {
    
    func getToDoEntity() -> Observable<[ToDoEntity]> {
        return Observable.create { observer in
            do {
                let realm = try Realm()
                
                let list = realm.objects(ToDoEntity.self)
                    .sorted(byKeyPath: "id", ascending: true)
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
    
    func saveToDoEntity(_ title: String) -> Observable<Void> {
        return Observable.create { observer in
            do {
                let realm = try Realm()
                let id = realm.objects(ToDoEntity.self).count
                let entity = ToDoEntity(id: id, title: title, state: false)
                
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
    
    func updateToDoEntity(_ id: Int) -> Observable<Void> {
        return Observable.create { observer in
            do {
                let realm = try Realm()
                
                let item = realm.object(ofType: ToDoEntity.self, forPrimaryKey: id)
                try realm.write {
                    item?.state = true
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
