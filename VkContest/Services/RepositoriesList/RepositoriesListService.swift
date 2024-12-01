//
//  RepositoriesListService.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation

protocol RepositoriesListService: AnyObject {
    func loadRepositories(sort: RepositoriesListSort, perPage: Int, page: Int) async throws -> [RepositoryListItem]
}

final class RepositoriesListServiceImpl {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension RepositoriesListServiceImpl: RepositoriesListService {
    func loadRepositories(sort: RepositoriesListSort, perPage: Int, page: Int) async throws -> [RepositoryListItem] {
        let request = RepositoriesListRequest(sort: sort, perPage: perPage, page: page)
        let response = try await networkManager.request(request: request)

        return response.items
    }
}
