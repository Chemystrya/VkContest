//
//  RepositoryEditingPresenter.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import Foundation
import UIKit

final class RepositoryEditingPresenter: NSObject {
    private weak var view: RepositoryEditingViewInput?
    private weak var moduleOutput: RepositoryEditingModuleOutput?

    private let interactor: RepositoryEditingInteractorInput
    private let pageNumber: Int
    private let sort: RepositoriesListSort

    private var item: RepositoryListItem

    init(
        view: RepositoryEditingViewInput?,
        interactor: RepositoryEditingInteractorInput,
        inputModel: RepositoryEditingInputModel
    ) {
        self.view = view
        self.interactor = interactor
        self.item = inputModel.item
        self.pageNumber = inputModel.pageNumber
        self.sort = inputModel.sort
        self.moduleOutput = inputModel.moduleOutput
    }
}

// MARK: - RepositoryEditingViewOutput
extension RepositoryEditingPresenter: RepositoryEditingViewOutput {
    func viewDidLoad() {
        view?.initialSetup(
            titleViewModel: TextFieldViewModel(
                name: "Название",
                value: item.name,
                type: .title,
                delegate: self
            ),
            descriptionViewModel: TextFieldViewModel(
                name: "Описание",
                value: item.description,
                type: .description,
                delegate: self
            )
        )

        view?.setupSaveButtonAction { [weak self] in
            guard let self else { return }
            
            self.interactor.edit(item: self.item, pageNumber: self.pageNumber, sort: self.sort)
        }
    }
}

// MARK: - RepositoryEditingInteractorOutput
extension RepositoryEditingPresenter: RepositoryEditingInteractorOutput {
    func repositoriesUpdated(with items: [RepositoryListItem]) {
        moduleOutput?.itemsUpdated(with: items)
    }
}

// MARK: - TextFieldDelegate
extension RepositoryEditingPresenter: TextFieldDelegate {
    func textFieldDidEndEditing(for type: TextFieldViewModel.FieldType, with text: String?) {
        switch type {
        case .title:
            item.name = text ?? ""
        case .description:
            item.description = text
        }
    }
}
