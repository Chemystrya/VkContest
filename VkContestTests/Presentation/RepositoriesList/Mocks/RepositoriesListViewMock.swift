//
//  RepositoriesListViewMock.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

@testable import VkContest
import UIKit

final class RepositoriesListViewMock {

    enum Call {
        case updateTableView
        case setTryAgainButtonVisibility
        case setupTryAgainButtonAction
        case startLoading
        case stopLoading
        case setupSortMenu
    }

    var calls: [Call] = []
}

extension RepositoriesListViewMock: RepositoriesListViewInput {
    func updateTableView(with dataSource: [RepositoriesListCellViewModel]) {
        calls.append(.updateTableView)
    }
    
    func setTryAgainButtonVisibility(isHidden: Bool) {
        calls.append(.setTryAgainButtonVisibility)
    }
    
    func setupTryAgainButtonAction(action: (() -> Void)?) {
        calls.append(.setupTryAgainButtonAction)
    }
    
    func startLoading() {
        calls.append(.startLoading)
    }
    
    func stopLoading() {
        calls.append(.stopLoading)
    }
    
    func setupSortMenu(with actions: [UIAction]) {
        calls.append(.setupSortMenu)
    }
}
