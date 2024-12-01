//
//  RepositoriesListAssembly.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import UIKit

final class RepositoriesListAssembly {
    static func assemble() -> UIViewController {
        let networkManager = NetworkManagerImpl()
        let service = RepositoriesListServiceImpl(networkManager: networkManager)
        let interactor = RepositoriesListInteractor(repositoriesListService: service)
        let view = RepositoriesListViewController()
        let presenter = RepositoriesListPresenter(view: view, interactor: interactor)
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
