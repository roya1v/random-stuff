//
//  CharacterDetailViewModel.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import Apollo
import Foundation
import RickAndMortyQueries

@MainActor
class CharacterDetailViewModel: ObservableObject {
    @Published private(set) var details: RickAndMortyQueries.CharacterDetailsQuery.Data.Character?

    private let id: String
    private let apolloClient = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)

    init(id: String) {
        self.id = id
    }

    func load() {
        Task {
            let result = await apolloClient.fetch(query: RickAndMortyQueries.CharacterDetailsQuery(id: id))
            switch result {
            case .success(let data):
                self.details = data.data?.character
            case .failure(let error):
                print(error)
            }
        }
    }
}
