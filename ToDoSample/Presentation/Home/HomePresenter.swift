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
    func saveToDo(title: String)
    func updateToDo(id: Int)
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
    
    func saveToDo(title: String) {
        useCase.saveToDo(title: title)
            .subscribe(onNext: { [weak self] _ in
                self?.loadToDo()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func updateToDo(id: Int) {
        useCase.updateToDo(id: id)
            .subscribe(onNext: { _ in
                // Not reload
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
