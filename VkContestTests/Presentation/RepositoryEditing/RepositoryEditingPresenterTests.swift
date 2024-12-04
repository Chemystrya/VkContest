//
//  RepositoryEditingPresenterTests.swift
//  VkContestTests
//
//  Created by Fedorova Maria on 04.12.2024.
//

import XCTest
@testable import VkContest

final class RepositoryEditingPresenterTests: XCTestCase {

    private lazy var sut = RepositoryEditingPresenter(
        view: view,
        interactor: interactor,
        inputModel: inputModel
    )

    private lazy var view = RepositoryEditingViewMock()
    private lazy var interactor = RepositoryEditingInteractorMock()
    private lazy var inputModel = RepositoryEditingInputModel(
        item: RepositoryListItem(id: 1, name: "name", owner: RepositoryListItem.Owner(avatarUrl: "avatarUrl")),
        pageNumber: 1,
        sort: .stars,
        moduleOutput: moduleOutput
    )
    private lazy var moduleOutput = RepositoryEditingModuleOutputMock()

    // MARK: - RepositoryEditingViewOutput

    func testViewDidLoad() {
        // Act
        sut.viewDidLoad()

        // Assert
        XCTAssertEqual(view.calls, [.initialSetup, .setupSaveButtonAction])
    }

    // MARK: - RepositoriesListViewOutput

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
        XCTAssertEqual(moduleOutput.calls, [.itemsUpdated])
    }

    // MARK: - TextFieldDelegate

    func testTextFieldDidEndEditing() {
        // Act
        sut.textFieldDidEndEditing(for: .title, with: "text")
    }
}
