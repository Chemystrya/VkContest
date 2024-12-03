//
//  RepositoriesListInteractor.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation

protocol RepositoriesListInteractorInput: AnyObject {
    func loadRepositories(with pageNumber: Int, sort: RepositoriesListSort)
    func deleteItem(with id: Int, pageNumber: Int, sort: RepositoriesListSort)
}

protocol RepositoriesListInteractorOutput: AnyObject {
    func repositoriesLoadedSuccessfully(with items: [RepositoryListItem])
    func repositoriesLoadFailed()
    func repositoriesUpdated(with items: [RepositoryListItem])
}

final class RepositoriesListInteractor {
    weak var output: RepositoriesListInteractorOutput?
    
    private let repositoriesListService: RepositoriesListService

    init(repositoriesListService: RepositoriesListService) {
        self.repositoriesListService = repositoriesListService
    }
}

// MARK: - RepositoriesListInteractorInput
extension RepositoriesListInteractor: RepositoriesListInteractorInput {
    func loadRepositories(with pageNumber: Int, sort: RepositoriesListSort) {
        Task {
            guard let items = try? await repositoriesListService.loadRepositories(pageNumber: pageNumber, sort: sort) else {
                await MainActor.run { output?.repositoriesLoadFailed() }
                return
            }

            await MainActor.run { output?.repositoriesLoadedSuccessfully(with: items) }
        }
    }

    func deleteItem(with id: Int, pageNumber: Int, sort: RepositoriesListSort) {
        Task {
            if let items = try? await repositoriesListService.delete(with: id, pageNumber: pageNumber, sort: sort) {
                await MainActor.run { output?.repositoriesUpdated(with: items) }
            }
        }
    }
}
