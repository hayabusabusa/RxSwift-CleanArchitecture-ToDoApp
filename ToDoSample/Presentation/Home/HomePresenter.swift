//
//  HomePresenter.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import RxSwift

protocol HomePresenter: class {
    func loadToDo()
    func saveToDo(id: Int, title: String)
}

class HomePresenterImpl: HomePresenter {
    
    private weak var view: HomeView?
    private let wireframe: HomeWireframe
    private let useCase: HomeUseCase
    
    private let disposeBag = DisposeBag()
    
    init(view: HomeView, wireframe: HomeWireframe, useCase: HomeUseCase) {
        self.view = view
        self.wireframe = wireframe
        self.useCase = useCase
    }
    
    func loadToDo() {
        useCase.getToDo()
            .subscribe(onNext: { [weak self] list in
                self?.view?.setToDo(list)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func saveToDo(id: Int, title: String) {
        let entity = ToDoEntity(id: id, title: title, state: false)
        useCase.saveToDo(entity: entity)
            .subscribe(onNext: { [weak self] _ in
                self?.loadToDo()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
