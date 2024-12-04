//
//  RepositoryEditingInteractorMock.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

@testable import VkContest

final class RepositoryEditingInteractorMock {

    enum Call {
        case edit
    }

    var calls: [Call] = []
}

extension RepositoryEditingInteractorMock: RepositoryEditingInteractorInput {
    func edit(item: RepositoryListItem, pageNumber: Int, sort: RepositoriesListSort) {
        calls.append(.edit)
    }
}
