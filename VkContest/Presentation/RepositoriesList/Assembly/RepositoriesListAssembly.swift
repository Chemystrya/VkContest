//
//  RepositoriesListAssembly.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import UIKit
import SwiftData

final class RepositoriesListAssembly {
    static func assemble() -> UIViewController {
        let networkManager = NetworkManagerImpl()
        let storage = RepositoriesListStorageImpl(container: try! ModelContainer(for: RepositoriesListPage.self))
        let service = RepositoriesListServiceImpl(networkManager: networkManager, storage: storage)
        let interactor = RepositoriesListInteractor(repositoriesListService: service)
        let view = RepositoriesListViewController()
        let router = RepositoriesListRouterImpl()
        router.transitionHandler = view
        let presenter = RepositoriesListPresenter(view: view, interactor: interactor, router: router)
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
