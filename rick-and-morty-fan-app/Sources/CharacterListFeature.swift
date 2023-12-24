//
//  CharacterListFeature.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import ComposableArchitecture
import Apollo
import Foundation
import RickAndMortyQueries

@Reducer
struct CharacterListFeature {
    struct State: Equatable {
        var characters: [RickAndMortyQueries.CharacterListQuery.Data.Characters.Result] = []
        var page = 0
    }

    enum Action {
        case loaded([RickAndMortyQueries.CharacterListQuery.Data.Characters.Result])
        case loadMore
    }

    let apolloClient = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadMore:
                state.page += 1
                return .run { [page = state.page] send in
                    let result = await apolloClient.fetch(query: RickAndMortyQueries.CharacterListQuery(page: GraphQLNullable<Int>(integerLiteral: page)))
                    switch result {
                    case .success(let data):
                        await send(.loaded(data.data!.characters!.results!.compactMap { $0 }))
                    case .failure(let error):
                        print(error)
                    }
                }
            case .loaded(let newValues):
                state.characters += newValues
                return .none
            }
        }
    }
}
