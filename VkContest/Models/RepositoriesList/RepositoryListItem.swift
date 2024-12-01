//
//  RepositoryListItem.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation

struct RepositoryListItem: Codable {
    let id: Int
    let name: String
    let description: String?
    let owner: Owner
}

// MARK: - Owner
extension RepositoryListItem {
    struct Owner: Codable {
        let avatarUrl: String
    }
}
