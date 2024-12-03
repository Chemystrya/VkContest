//
//  GitHubApi.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Alamofire

protocol GitHubApi: ApiRequest {}

extension GitHubApi {
    var basePath: String { "https://api.github.com" }
}

// MARK: - https://docs.github.com/ru/rest/search/search?apiVersion=2022-11-28#search-repositories
struct RepositoriesListRequest: GitHubApi {    
    typealias SuccessResponse = RepositoriesListResponse

    private let pageNumber: Int
    private let sort: RepositoriesListSort

    init(
        pageNumber: Int,
        sort: RepositoriesListSort
    ) {
        self.pageNumber = pageNumber
        self.sort = sort
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/search/repositories"
    }

    var params: Parameters? {
        [
            "q": "swift",
            "sort": sort.rawValue,
            "per_page": 15,
            "page": pageNumber,
            "order": "desc"
        ]
    }
}
