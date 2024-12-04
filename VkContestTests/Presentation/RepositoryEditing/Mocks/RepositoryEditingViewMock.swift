//
//  RepositoryEditingViewMock.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

@testable import VkContest
import UIKit

final class RepositoryEditingViewMock {

    enum Call {
        case initialSetup
        case setupSaveButtonAction
    }

    var calls: [Call] = []
}

extension RepositoryEditingViewMock: RepositoryEditingViewInput {
    func initialSetup(titleViewModel: TextFieldViewModel, descriptionViewModel: TextFieldViewModel) {
        calls.append(.initialSetup)
    }
    
    func setupSaveButtonAction(action: (() -> Void)?) {
        calls.append(.setupSaveButtonAction)
    }
}
