//
//  HomeBuilder.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

protocol HomeBuilder {
    func build() -> UIViewController
}

struct HomeBuilderImpl: HomeBuilder {
    
    func build() -> UIViewController {
        let viewController = HomeViewController.newInstance()
        viewController.inject(
            presenter: HomePresenterImpl(
                view: viewController,
                wireframe: HomeWireframeImpl(
                    viewController: viewController
                ),
                useCase: HomeUseCaseImpl(
                    repository: HomeRepositoryImpl(
                        dataStore: HomeDataStoreImpl()
                    )
                )
            )
        )
        
        return viewController
    }
}
