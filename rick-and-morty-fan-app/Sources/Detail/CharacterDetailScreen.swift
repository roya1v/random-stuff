//
//  CharacterDetailView.swift
//  RickAndMortyFanApp
//
//  Created by Mike S. on 07/12/2023.
//

import SwiftUI

struct CharacterDetailView: View {

    @StateObject var model: CharacterDetailViewModel

    init(characterID: String) {
        _model = StateObject(wrappedValue: CharacterDetailViewModel(id: characterID))
    }

    var body: some View {
        ScrollView(.vertical) {
            if let character = model.details {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: character.image!)!) { image in
                        ZStack(alignment: .bottom) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)

                            Text(character.name!)
                                .font(.largeTitle)
                                .padding()
                                .background(.ultraThinMaterial)
                        }
                    } placeholder: {
                        Text(character.name!)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    HStack {
                        switch character.gender {
                        case "Male":
                            Text("♂")
                                .bold()
                                .font(.system(size: 24.0))
                                .foregroundStyle(.blue)
                        default:
                            Text("?")
                                .bold()
                                .font(.system(size: 24.0))
                                .foregroundStyle(.white)
                        }
                        Text(character.status!)
                            .foregroundStyle(.white)
                        Text(character.species!)
                            .foregroundStyle(.white)
                        Text(character.origin!.name!)
                            .foregroundStyle(.white)
                        Text(character.location!.name!)
                            .foregroundStyle(.white)
                    }

                    Text(String.placeholder)
                        .foregroundStyle(.white)
                    Text("Episodes")
                        .font(.title)
                        .foregroundStyle(.white)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(character.episode.compactMap { $0 },
                                    id: \.id!) { episode in
                                ZStack {
                                    Rectangle()
                                        .background(Color.color2)
                                        .frame(width: 130.0, height: 100.0)
                                    VStack {
                                        Text(episode.episode!)
                                            .foregroundStyle(.gray)
                                            .font(.caption)
                                        Text(episode.name!)
                                            .foregroundStyle(.white)
                                    }

                                }

                            }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.color1)
        .onAppear {
            model.load()
        }
    }
}

#Preview {
    CharacterDetailView(characterID: "1")
}
