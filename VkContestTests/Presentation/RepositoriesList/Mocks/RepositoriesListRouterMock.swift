//
//  RepositoriesListRouterMock.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

@testable import VkContest

final class RepositoriesListRouterMock {

    enum Call {
        case showEditingScreen
    }

    var calls: [Call] = []
}

extension RepositoriesListRouterMock: RepositoriesListRouterInput {
    func showEditingScreen(with inputModel: RepositoryEditingInputModel) {
        calls.append(.showEditingScreen)
    }
}
