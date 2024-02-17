//
//  CharacterListView.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import SwiftUI

struct CharacterListScreen: View {

    @State var model = CharacterListModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(model.characters, id: \.self) { character in
                    CharacterCellView(character: character)
                }
                ProgressView()
                    .listRowBackground(Color.color1)
                    .onAppear {
                        model.loadMore()
                    }
            }
            .background(Color.color2)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Characters")
        .navigationDestination(for: String.self) { id in
            CharacterDetailView(characterID: id)
        }
    }
}

#Preview {
    CharacterListScreen()
}
