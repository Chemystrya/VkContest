//
//  RepositoryEditingAssembly.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import UIKit
import SwiftData

protocol RepositoryEditingModuleOutput: AnyObject {
    func itemsUpdated(with items: [RepositoryListItem])
}

struct RepositoryEditingInputModel {
    let item: RepositoryListItem
    let pageNumber: Int
    let sort: RepositoriesListSort
    weak var moduleOutput: RepositoryEditingModuleOutput?
}

final class RepositoryEditingAssembly {
    static func assemble(with inputModel: RepositoryEditingInputModel) -> UIViewController {
        let networkManager = NetworkManagerImpl()
        let storage = RepositoriesListStorageImpl(container: try! ModelContainer(for: RepositoriesListPage.self))
        let service = RepositoriesListServiceImpl(networkManager: networkManager, storage: storage)
        let interactor = RepositoryEditingInteractor(repositoriesListService: service)
        let view = RepositoryEditingViewController()
        let presenter = RepositoryEditingPresenter(view: view, interactor: interactor, inputModel: inputModel)
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
