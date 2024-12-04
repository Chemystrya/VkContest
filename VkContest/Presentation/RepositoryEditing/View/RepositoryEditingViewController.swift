//
//  RepositoryEditingViewController.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import UIKit

protocol RepositoryEditingViewInput: AnyObject {
    func initialSetup(titleViewModel: TextFieldViewModel, descriptionViewModel: TextFieldViewModel)
    func setupSaveButtonAction(action: (() -> Void)?)
}

protocol RepositoryEditingViewOutput: AnyObject {
    func viewDidLoad()
}

final class RepositoryEditingViewController: UIViewController {
    var output: RepositoryEditingViewOutput?

    private let titleTextField = TextField()
    private let descriptionTextField = TextField()
    private let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        hideKeyboardWhenTappedAround()
        output?.viewDidLoad()
    }
}

// MARK: - RepositoriesListViewInput
extension RepositoryEditingViewController: RepositoryEditingViewInput {
    func initialSetup(titleViewModel: TextFieldViewModel, descriptionViewModel: TextFieldViewModel) {
        titleTextField.setup(with: titleViewModel)
        descriptionTextField.setup(with: descriptionViewModel)
    }

    func setupSaveButtonAction(action: (() -> Void)?) {
        saveButton.addAction(UIAction { _ in action?() }, for: .touchUpInside)
    }
}

// MARK: - Private methods
extension RepositoryEditingViewController {
    private func commonInit() {
        view.backgroundColor = .white
        let views: [UIView] = [titleTextField, descriptionTextField, saveButton]
        views.forEach { view.addSubview($0) }

        setupConstraints()
    }

    private func setupConstraints() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

                descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
                descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),

                saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
                saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                saveButton.heightAnchor.constraint(equalToConstant: 64)
            ]
        )
    }
}
