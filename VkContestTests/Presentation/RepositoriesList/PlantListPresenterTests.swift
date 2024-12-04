//
//  RepositoriesListPresenterTests.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

import XCTest
@testable import VkContest

final class RepositoriesListPresenterTests: XCTestCase {

    private lazy var sut = RepositoriesListPresenter(
        view: view,
        interactor: interactor,
        router: router
    )

    private let view = RepositoriesListViewMock()
    private let interactor = RepositoriesListInteractorMock()
    private let router = RepositoriesListRouterMock()

    // MARK: - RepositoriesListViewOutput

    func testViewDidLoad() {
        // Act
        sut.viewDidLoad()

        // Assert
        XCTAssertEqual(interactor.calls, [.loadRepositories])
        XCTAssertEqual(view.calls, [.startLoading, .setTryAgainButtonVisibility, .setupTryAgainButtonAction, .setupSortMenu])
    }

    func testWillDisplayCell() {
        // Arrange
        sut.repositoriesLoadedSuccessfully(
            with: [
                RepositoryListItem(
                    id: 1,
                    name: "name",
                    description: "description",
                    owner: RepositoryListItem.Owner(avatarUrl: "avatarUrl")
                )
            ]
        )

        // Act
        sut.willDisplayCell(with: IndexPath(row: 0, section: 0))

        // Assert
        XCTAssertEqual(interactor.calls, [.loadRepositories])
        XCTAssertEqual(view.calls, [.stopLoading, .updateTableView, .startLoading, .setTryAgainButtonVisibility])
    }

    func testDeleteItem() {
        // Arrange
        sut.repositoriesLoadedSuccessfully(
            with: [
                RepositoryListItem(
                    id: 1,
                    name: "name",
                    description: "description",
                    owner: RepositoryListItem.Owner(avatarUrl: "avatarUrl")
                )
            ]
        )

        // Act
        sut.deleteItem(at: IndexPath(row: 0, section: 0))

        // Assert
        XCTAssertEqual(interactor.calls, [.deleteItem])
    }

    func testChangeItem() {
        // Arrange
        sut.repositoriesLoadedSuccessfully(
            with: [
                RepositoryListItem(
                    id: 1,
                    name: "name",
                    description: "description",
                    owner: RepositoryListItem.Owner(avatarUrl: "avatarUrl")
                )
            ]
        )
        
        // Act
        sut.changeItem(at: IndexPath(row: 0, section: 0))

        // Assert
        XCTAssertEqual(router.calls, [.showEditingScreen])
    }

    // MARK: - RepositoriesListViewOutput

    func testRepositoriesLoadedSuccessfully() {
        // Act
        sut.repositoriesLoadedSuccessfully(
            with: [
                RepositoryListItem(
                    id: 1,
                    name: "name",
                    description: "description",
                    owner: RepositoryListItem.Owner(avatarUrl: "avatarUrl")
                )
            ]
        )

        // Assert
        XCTAssertEqual(view.calls, [.stopLoading, .updateTableView])
    }

    func testRepositoriesLoadFailed() {
        // Act
        sut.repositoriesLoadFailed()

        // Assert
        XCTAssertEqual(view.calls, [.stopLoading, .setTryAgainButtonVisibility])
    }

    func testRepositoriesUpdated() {
        // Act
        sut.repositoriesUpdated(
            with: [
                RepositoryListItem(
                    id: 1,
                    name: "name",
                    description: "description",
                    owner: RepositoryListItem.Owner(avatarUrl: "avatarUrl")
                )
            ]
        )

        // Assert
        XCTAssertEqual(view.calls, [.updateTableView])
    }

    // MARK: - RepositoryEditingModuleOutput

    func testItemsUpdated() {
        // Act
        sut.itemsUpdated(
            with: [
                RepositoryListItem(
                    id: 1,
                    name: "name",
                    description: "description",
                    owner: RepositoryListItem.Owner(avatarUrl: "avatarUrl")
                )
            ]
        )

        // Assert
        XCTAssertEqual(view.calls, [.updateTableView])
    }
}
