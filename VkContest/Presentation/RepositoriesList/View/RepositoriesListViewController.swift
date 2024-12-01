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
}

protocol RepositoriesListViewOutput: AnyObject {
    func viewDidLoad()
}

final class RepositoriesListViewController: UIViewController {
    typealias DiffableDataSource = UITableViewDiffableDataSource<Int, RepositoriesListCellViewModel>

    var output: RepositoriesListViewOutput?

    private lazy var diffableDataSource = makeDiffableDataSource()

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.backgroundColor = .red
        output?.viewDidLoad()
    }
}

// MARK: - RepositoriesListViewInput
extension RepositoriesListViewController: RepositoriesListViewInput {
    func updateTableView(with dataSource: [RepositoriesListCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RepositoriesListCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(dataSource, toSection: 0)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Private methods
extension RepositoriesListViewController {
    private func makeDiffableDataSource() -> DiffableDataSource {
        let dataSource = DiffableDataSource(tableView: tableView) { tableView, indexPath, viewModel in
            tableView.dequeueReusableCellWithRegistration(type: RepositoriesListCell.self, indexPath: indexPath)
        }

        return dataSource
    }
}

