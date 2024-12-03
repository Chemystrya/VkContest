//
//  RepositoriesListPage.swift
//  VkContest
//
//  Created by Fedorova Maria on 03.12.2024.
//

import SwiftData

@Model
final class RepositoriesListPage {
    var number: Int
    var sort: RepositoriesListSort
    var items: [RepositoryListItem]

    init(
        number: Int,
        sort: RepositoriesListSort,
        items: [RepositoryListItem]
    ) {
        self.number = number
        self.sort = sort
        self.items = items
    }
}
