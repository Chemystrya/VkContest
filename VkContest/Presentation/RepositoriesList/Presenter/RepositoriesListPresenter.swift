//
//  RepositoriesListPresenter.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation

final class RepositoriesListPresenter {
    private weak var view: RepositoriesListViewInput?
    private let interactor: RepositoriesListInteractor
    private let router: RepositoriesListRouter
    private let perPage = 15

    private var items: [RepositoryListItem] = []
    private var pageNumber = 1
    private var sort: RepositoriesListSort = .stars

    init(
        view: RepositoriesListViewInput?,
        interactor: RepositoriesListInteractor,
        router: RepositoriesListRouter
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - RepositoriesListViewOutput
extension RepositoriesListPresenter: RepositoriesListViewOutput {
    func viewDidLoad() {
        loadRepositories()
        view?.setupTryAgainButtonAction { [weak self] in
            self?.loadRepositories()
        }
    }

    func willDisplayCell(with indexPath: IndexPath) {
        if indexPath.row == items.count - 1 {
            pageNumber += 1
            loadRepositories()
        }
    }

    func deleteItem(at indexPath: IndexPath) {
        let item = items[indexPath.row]
        let pageNumber = indexPath.row / perPage + 1
        interactor.deleteItem(with: item.id, pageNumber: pageNumber, sort: sort)
    }

    func changeItem(at indexPath: IndexPath) {
        let item = items[indexPath.row]
        router.showEditingScreen(
            with: RepositoryEditingInputModel(item: item, pageNumber: pageNumber, sort: sort, moduleOutput: self)
        )
    }
}

// MARK: - RepositoriesListViewOutput
extension RepositoriesListPresenter: RepositoriesListInteractorOutput {
    func repositoriesLoadedSuccessfully(with items: [RepositoryListItem]) {
        self.items += items

        view?.stopLoading()
        updateDataSource()
    }

    func repositoriesLoadFailed() {
        view?.stopLoading()
        view?.setTryAgainButtonVisibility(isHidden: false)
    }

    func repositoriesUpdated(with items: [RepositoryListItem]) {
        self.items = items
        pageNumber = items.count / perPage + 1
        updateDataSource()
    }
}

// MARK: - RepositoryEditingModuleOutput
extension RepositoriesListPresenter: RepositoryEditingModuleOutput {
    func itemsUpdated(with items: [RepositoryListItem]) {
        self.items = items
        updateDataSource()
    }
}

// MARK: - Private methods
extension RepositoriesListPresenter {
    private func loadRepositories() {
        view?.startLoading()
        view?.setTryAgainButtonVisibility(isHidden: true)
        interactor.loadRepositories(with: pageNumber, sort: sort)
    }

    private func updateDataSource() {
        let viewModels = items.map { item in
            RepositoriesListCellViewModel(
                title: item.name,
                description: item.description ?? "no description",
                avatarUrl: URL(string: item.owner.avatarUrl)
            )
        }
        view?.updateTableView(with: viewModels)
    }
}
