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
