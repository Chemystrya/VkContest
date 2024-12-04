//
//  RepositoriesListInteractorMock.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

@testable import VkContest

final class RepositoriesListInteractorMock {

    enum Call {
        case loadRepositories
        case deleteItem
    }

    var calls: [Call] = []
}

extension RepositoriesListInteractorMock: RepositoriesListInteractorInput {
    func loadRepositories(with pageNumber: Int, sort: RepositoriesListSort) {
        calls.append(.loadRepositories)
    }
    
    func deleteItem(with id: Int, pageNumber: Int, sort: RepositoriesListSort) {
        calls.append(.deleteItem)
    }
}
