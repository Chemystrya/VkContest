//
//  ApiRequest.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Alamofire
import Foundation

protocol ApiRequest: Endpoint & Decoding {}

protocol Endpoint {
    var basePath: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var params: Parameters? { get }
    var httpBody: Data? { get }
}

extension Endpoint {
    var headers: [String: String] { return [:] }
    var httpBody: Data? { return nil }
}

protocol Decoding {
    associatedtype SuccessResponse: Codable
}
