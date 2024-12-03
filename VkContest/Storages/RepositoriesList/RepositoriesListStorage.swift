//
//  RepositoriesListStorage.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import SwiftData

protocol RepositoriesListStorage {
    func fetch(with pageNumber: Int, sort: RepositoriesListSort) async throws -> RepositoriesListPage?
    func save(page: RepositoriesListPage) async
    func delete(with id: Int, pageNumber: Int, sort: RepositoriesListSort) async throws -> RepositoriesListPage?
    func deleteAll() async
    func edit(item: RepositoryListItem, pageNumber: Int, sort: RepositoriesListSort) async throws -> [RepositoriesListPage]?
}

final class RepositoriesListStorageImpl: RepositoriesListStorage {
    private let container: ModelContainer

    init(container: ModelContainer) {
        self.container = container
    }

    func fetch(with pageNumber: Int, sort: RepositoriesListSort) async throws -> RepositoriesListPage? {
        let descriptor = FetchDescriptor<RepositoriesListPage>()
        let context = ModelContext(container)
        let pages = try context.fetch(descriptor)
        let page = pages.first(where: { $0.number == pageNumber && $0.sort == sort })

        return page
    }

    @MainActor func save(page: RepositoriesListPage) {
        container.mainContext.insert(page)

        try? container.mainContext.save()
    }

    @MainActor func delete(with id: Int, pageNumber: Int, sort: RepositoriesListSort) throws -> RepositoriesListPage? {
        let descriptor = FetchDescriptor<RepositoriesListPage>()
        let pages = try? container.mainContext.fetch(descriptor)
        
        guard let page = pages?.first(where: { $0.number == pageNumber && $0.sort == sort }) else { return nil }

        page.items.removeAll(where: { $0.id == id })

        try container.mainContext.save()

        return page
    }

    @MainActor func deleteAll() {
        try? container.mainContext.delete(model: RepositoriesListPage.self)
    }

    @MainActor func edit(item: RepositoryListItem, pageNumber: Int, sort: RepositoriesListSort) throws -> [RepositoriesListPage]? {
        let descriptor = FetchDescriptor<RepositoriesListPage>()
        let pages = try? container.mainContext.fetch(descriptor)

        guard
            let page = pages?.first(where: { $0.number == pageNumber && $0.sort == sort }),
            let index = page.items.firstIndex(where: { $0.id == item.id })
        else {
            return pages
        }

        page.items[index] = item

        try container.mainContext.save()

        return pages?.sorted(by: { $0.number < $1.number })
    }
}
