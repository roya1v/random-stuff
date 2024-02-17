//
//  CharacterListView.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import SwiftUI

struct CharacterCellView: View {

    let character: RickAndMortyQueries.CharacterListQuery.Data.Characters.Result

    var body: some View {
        NavigationLink(value: character.id) {
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
        }
        .listRowBackground(Color.color1)
    }
}
