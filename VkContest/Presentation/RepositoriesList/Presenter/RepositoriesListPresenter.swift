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

    init(view: RepositoriesListViewInput?, interactor: RepositoriesListInteractor) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - RepositoriesListViewOutput
extension RepositoriesListPresenter: RepositoriesListViewOutput {
    func viewDidLoad() {
        interactor.loadRepositories(with: .stars, page: 1)
    }
}

// MARK: - RepositoriesListViewOutput
extension RepositoriesListPresenter: RepositoriesListInteractorOutput {
    func repositoriesLoadedSuccessfully(with items: [RepositoryListItem]) {
        print(items)
    }

    func repositoriesLoadFailed() {
        print("failed")
    }
}
