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

    private let sort: RepositoriesListSort
    private let perPage: Int
    private let page: Int

    init(
        sort: RepositoriesListSort,
        perPage: Int,
        page: Int
    ) {
        self.sort = sort
        self.perPage = perPage
        self.page = page
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
            "per_page": perPage,
            "page": page,
            "order": "desc"
        ]
    }
}
