//
//  RepositoriesListService.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation

protocol RepositoriesListService: AnyObject {
    func loadRepositories(pageNumber: Int, sort: RepositoriesListSort) async throws -> [RepositoryListItem]
    func delete(with id: Int, pageNumber: Int, sort: RepositoriesListSort) async throws -> [RepositoryListItem]?
    func edit(item: RepositoryListItem, pageNumber: Int, sort: RepositoriesListSort) async throws -> [RepositoryListItem]?
}

final class RepositoriesListServiceImpl {
    private let networkManager: NetworkManager
    private let storage: RepositoriesListStorage

    init(
        networkManager: NetworkManager,
        storage: RepositoriesListStorage
    ) {
        self.networkManager = networkManager
        self.storage = storage
    }
}

extension RepositoriesListServiceImpl: RepositoriesListService {
    func loadRepositories(pageNumber: Int, sort: RepositoriesListSort) async throws -> [RepositoryListItem] {
        if let page = try? await storage.fetch(with: pageNumber, sort: sort) {
            return page.items
        }

        let request = RepositoriesListRequest(pageNumber: pageNumber, sort: sort)
        let response = try await networkManager.request(request: request)

        await storage.save(page: RepositoriesListPage(number: pageNumber, sort: sort, items: response.items))

        return response.items
    }

    func delete(with id: Int, pageNumber: Int, sort: RepositoriesListSort) async throws -> [RepositoryListItem]? {
        let page = try await storage.delete(with: id, pageNumber: pageNumber, sort: sort)

        return page?.items
    }

    func edit(item: RepositoryListItem, pageNumber: Int, sort: RepositoriesListSort) async throws -> [RepositoryListItem]? {
        let pages = try await storage.edit(item: item, pageNumber: pageNumber, sort: sort)
        let items = pages?
            .map { $0.items }
            .flatMap { $0 }

        return items
    }
}
