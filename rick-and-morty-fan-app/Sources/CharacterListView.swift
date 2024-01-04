//
//  CharacterListView.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import SwiftUI
import ComposableArchitecture

struct CharacterListView: View {

    let store: StoreOf<CharacterListFeature>

    var body: some View {
        NavigationView {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                List {
                    ForEach(viewStore.characters, id: \.self) { character in
                        CharacterCellView(character: character)
                    }
                    ProgressView()
                        .listRowBackground(Color.color1)
                        .onAppear {
                            viewStore.send(.loadMore)
                        }
                }
                .background(Color.color2)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Characters")
        }

    }
}

struct CharacterCellView: View {

    let character: RickAndMortyQueries.CharacterListQuery.Data.Characters.Result

    var body: some View {
            HStack {
                AsyncImage(url: URL(string: character.image!)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0)
                } placeholder: {
                    ProgressView()
                }
                VStack {
                    Text(character.name!)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                    Text(character.status!)
                        .foregroundStyle(Color.color3)
                    Text(character.type!)
                        .foregroundStyle(Color.color3)
                    Text(character.species!)
                        .foregroundStyle(Color.color3)
                    Text(character.gender!)
                        .foregroundStyle(Color.color3)
                }
                .frame(maxWidth: .infinity)

        }
            .listRowBackground(Color.color1)
    }
}

#Preview {
    CharacterListView(store: Store(initialState: CharacterListFeature.State(), reducer: {
        CharacterListFeature()
    }))
}
