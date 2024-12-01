//
//  RepositoriesListInteractor.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation

protocol RepositoriesListInteractorInput: AnyObject {
    func loadRepositories(with sort: RepositoriesListSort, page: Int)
}

protocol RepositoriesListInteractorOutput: AnyObject {
    func repositoriesLoadedSuccessfully(with items: [RepositoryListItem])
    func repositoriesLoadFailed()
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
    func loadRepositories(with sort: RepositoriesListSort, page: Int) {
        Task {
            guard let items = try? await repositoriesListService.loadRepositories(
                sort: sort, 
                perPage: 30,
                page: 1
            ) else {
                await MainActor.run { output?.repositoriesLoadFailed() }
                return
            }

            await MainActor.run { output?.repositoriesLoadedSuccessfully(with: items) }
        }

    }
    
    
}
