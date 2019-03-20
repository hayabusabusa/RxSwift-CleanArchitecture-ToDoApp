//
//  HomeWireframe.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

protocol HomeWireframe {
    
}

class HomeWireframeImpl: HomeWireframe {
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
