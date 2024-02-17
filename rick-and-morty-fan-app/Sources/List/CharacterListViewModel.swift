//
//  CharacterListFeature.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import Apollo
import Foundation
import RickAndMortyQueries

@Observable
class CharacterListModel {
    var characters: [RickAndMortyQueries.CharacterListQuery.Data.Characters.Result] = []

    private var page = 0
    private let apolloClient = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)

    func loadMore() {
        page += 1
        Task {
            let result = await apolloClient.fetch(query: RickAndMortyQueries.CharacterListQuery(page: GraphQLNullable<Int>(integerLiteral: page)))
            switch result {
            case .success(let data):
                characters.append(contentsOf: data.data!.characters!.results!.compactMap { $0 })
            case .failure(let error):
                print(error)
            }
        }
    }
}
