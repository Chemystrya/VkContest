//
//  RepositoriesListRouter.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import UIKit

protocol RepositoriesListRouter {
    func showEditingScreen(with inputModel: RepositoryEditingInputModel)
}

final class RepositoriesListRouterImpl: BaseRouter {}

extension RepositoriesListRouterImpl: RepositoriesListRouter {
    func showEditingScreen(with inputModel: RepositoryEditingInputModel) {
        let viewController = RepositoryEditingAssembly.assemble(with: inputModel)
        transitionHandler?.pushModule(with: viewController, animated: true)
    }
}
