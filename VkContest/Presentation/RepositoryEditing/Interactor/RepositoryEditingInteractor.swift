//
//  RepositoryEditingInteractor.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import Foundation

protocol RepositoryEditingInteractorInput: AnyObject {
    func edit(item: RepositoryListItem, pageNumber: Int, sort: RepositoriesListSort)
}

protocol RepositoryEditingInteractorOutput: AnyObject {
    func repositoriesUpdated(with items: [RepositoryListItem])
}

final class RepositoryEditingInteractor {
    weak var output: RepositoryEditingInteractorOutput?

    private let repositoriesListService: RepositoriesListService

    init(repositoriesListService: RepositoriesListService) {
        self.repositoriesListService = repositoriesListService
    }
}

// MARK: - RepositoryEditingInteractorInput
extension RepositoryEditingInteractor: RepositoryEditingInteractorInput {
    func edit(item: RepositoryListItem, pageNumber: Int, sort: RepositoriesListSort) {
        Task {
            guard let items = try? await repositoriesListService.edit(
                item: item,
                pageNumber: pageNumber,
                sort: sort
            ) else { return }

            await MainActor.run { output?.repositoriesUpdated(with: items) }
        }
    }
}
