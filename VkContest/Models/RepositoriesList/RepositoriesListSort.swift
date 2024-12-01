//
//  RepositoriesListSort.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation

enum RepositoriesListSort: String, Codable {
    case stars
    case forks
    case helpWantedIssues = "help-wanted-issues"
    case updated
}
