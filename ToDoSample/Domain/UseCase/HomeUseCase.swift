//
//  HomeUseCase.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getToDo() -> Observable<[ToDoViewModel]>
    func saveToDo(title: String) -> Observable<Void>
    func updateToDo(id: Int) -> Observable<Void> 
}

struct HomeUseCaseImpl: HomeUseCase {
    
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func getToDo() -> Observable<[ToDoViewModel]> {
        return repository.getToDoEntity()
            .flatMap { list -> Observable<[ToDoViewModel]> in
                let result = list.reduce(into: [ToDoViewModel]()) { (result, item) in
                    if !item.state {
                        result.append(ToDoViewModel(item))
                    }
                }
                return Observable.just(result)
            }
    }
    
    func saveToDo(title: String) -> Observable<Void> {
        return repository.saveToDoEntity(title)
    }
    
    func updateToDo(id: Int) -> Observable<Void> {
        return repository.updateToDoEntity(id)
    }
}
