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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                ForEach(viewStore.characters, id: \.self) { character in
                    HStack {
                        AsyncImage(url: URL(string: character.image!)!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100.0)
                        } placeholder: {
                            ProgressView()
                        }


                        Text(character.name!)
                    }

                }
                Text("Wow loading more")
                    .onAppear {
                        viewStore.send(.loadMore)
                    }
            }

        }
    }
}

#Preview {
    CharacterListView(store: Store(initialState: CharacterListFeature.State(), reducer: {
        CharacterListFeature()
    }))
}
