//
//  RepositoryEditingModuleOutputMock.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

@testable import VkContest
import UIKit

final class RepositoryEditingModuleOutputMock {

    enum Call {
        case itemsUpdated
    }

    var calls: [Call] = []
}

extension RepositoryEditingModuleOutputMock: RepositoryEditingModuleOutput {
    func itemsUpdated(with items: [RepositoryListItem]) {
        calls.append(.itemsUpdated)
    }
}
