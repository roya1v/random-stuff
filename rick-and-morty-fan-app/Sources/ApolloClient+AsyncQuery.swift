//
//  ApolloClient+AsyncQuery.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import Apollo
import Foundation
import ApolloAPI

extension ApolloClient {
    func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .default,
        contextIdentifier: UUID? = nil,
        context: RequestContext? = nil) async -> Result<GraphQLResult<Query.Data>, Error> {
            return await withCheckedContinuation { continuation in
                fetch(query: query, cachePolicy: cachePolicy, contextIdentifier: contextIdentifier, context: context) { result in
                    continuation.resume(returning: result)
                }
            }
        }
}

extension String {
    static let placeholder = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
}
