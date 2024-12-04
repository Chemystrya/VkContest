//
//  RepositoriesListViewController.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import UIKit
import Kingfisher

protocol RepositoriesListViewInput: AnyObject {
    func updateTableView(with dataSource: [RepositoriesListCellViewModel])
    func setTryAgainButtonVisibility(isHidden: Bool)
    func setupTryAgainButtonAction(action: (() -> Void)?)
    func startLoading()
    func stopLoading()
    func setupSortMenu(with actions: [UIAction])
}

protocol RepositoriesListViewOutput: AnyObject {
    func viewDidLoad()
    func willDisplayCell(with indexPath: IndexPath)
    func deleteItem(at indexPath: IndexPath)
    func changeItem(at indexPath: IndexPath)
}

final class RepositoriesListViewController: UIViewController {
    typealias DiffableDataSource = UITableViewDiffableDataSource<Int, RepositoriesListCellViewModel>

    var output: RepositoriesListViewOutput?

    private lazy var diffableDataSource = makeDiffableDataSource()

    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let tryAgainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Попробовать снова", for: .normal)
        button.isHidden = true
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    private var displayLink = CADisplayLink()

    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        output?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setUpDisplayLink()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        displayLink.remove(from: .main, forMode: RunLoop.Mode.common)
    }
}

// MARK: - RepositoriesListViewInput
extension RepositoriesListViewController: RepositoriesListViewInput {
    func updateTableView(with dataSource: [RepositoriesListCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RepositoriesListCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(dataSource, toSection: 0)
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }

    func setTryAgainButtonVisibility(isHidden: Bool) {
        tryAgainButton.isHidden = isHidden
    }

    func setupTryAgainButtonAction(action: (() -> Void)?) {
        tryAgainButton.addAction(UIAction { _ in action?() }, for: .touchUpInside)
    }

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

    func setupSortMenu(with actions: [UIAction]) {
        let menu = UIMenu(title: "Выберите принцип сортировки:", image: nil, identifier: nil, options: [], children: actions)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "",
            image: UIImage(systemName: "arrow.up.arrow.down")?.withTintColor(.black, renderingMode: .alwaysOriginal),
            primaryAction: nil,
            menu: menu
        )
    }
}

// MARK: - UITableViewDelegate
extension RepositoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output?.willDisplayCell(with: indexPath)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, completion in
            self?.output?.deleteItem(at: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }

    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Изменить") { [weak self] _, _, completion in
            self?.output?.changeItem(at: indexPath)
            completion(true)
        }
        let config = UISwipeActionsConfiguration(actions: [editAction])
        return config
    }
}

// MARK: - Private methods
extension RepositoriesListViewController {
    private func makeDiffableDataSource() -> DiffableDataSource {
        DiffableDataSource(tableView: tableView) { tableView, indexPath, viewModel in
            let cell = tableView.dequeueReusableCellWithRegistration(type: RepositoriesListCell.self, indexPath: indexPath)
            cell.setup(with: viewModel)
            cell.selectionStyle = .none
            return cell
        }
    }

    private func commonInit() {
        view.backgroundColor = .white
        tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        let views: [UIView] = [tableView, activityIndicator, tryAgainButton]
        views.forEach { view.addSubview($0) }
        tableView.separatorStyle = .none
        tableView.delegate = self
        activityIndicator.style = .large
        activityIndicator.color = .black

        setupConstraints()
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                tryAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tryAgainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                tryAgainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                tryAgainButton.heightAnchor.constraint(equalToConstant: 64)
            ]
        )
    }

    private func setUpDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: RunLoop.Mode.common)
    }

    @objc private func update() {
        let actualFramesPerSecond = 1 / (displayLink.targetTimestamp - displayLink.timestamp)
        title = "FPS: " + String(format: "%.010f", actualFramesPerSecond)
    }
}
