//
//  BaseRouter.swift
//  VkContest
//
//  Created by Fedorova Maria on 04.12.2024.
//

protocol ModuleDismissable: AnyObject {
    func back()
}

class BaseRouter: ModuleDismissable {
    weak var transitionHandler: TransitionHandler?

    func back() {
        transitionHandler?.back()
    }
}
