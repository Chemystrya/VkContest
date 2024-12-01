//
//  NetworkManager.swift
//  VkContest
//
//  Created by Fedorova Maria on 01.12.2024.
//

import Foundation
import Alamofire

protocol NetworkManager {
    func request<T: ApiRequest>(request: T) async throws -> T.SuccessResponse
}

actor NetworkManagerImpl: NetworkManager {
    func request<T: ApiRequest>(request: T) async throws -> T.SuccessResponse {
        let encoding: ParameterEncoding = switch request.method {
        case .post:
            JSONEncoding.default
        case .get:
            URLEncoding.default
        default:
            JSONEncoding.default
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                request.basePath + request.path,
                method: request.method,
                parameters: request.params,
                encoding: encoding,
                headers: HTTPHeaders(request.headers)
            ).responseDecodable(of: T.SuccessResponse.self, decoder: decoder) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

