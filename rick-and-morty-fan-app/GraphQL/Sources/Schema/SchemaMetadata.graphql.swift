// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol RickAndMortyQueries_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == RickAndMortyQueries.SchemaMetadata {}

public protocol RickAndMortyQueries_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == RickAndMortyQueries.SchemaMetadata {}

public protocol RickAndMortyQueries_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == RickAndMortyQueries.SchemaMetadata {}

public protocol RickAndMortyQueries_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == RickAndMortyQueries.SchemaMetadata {}

public extension RickAndMortyQueries {
  typealias ID = String

  typealias SelectionSet = RickAndMortyQueries_SelectionSet

  typealias InlineFragment = RickAndMortyQueries_InlineFragment

  typealias MutableSelectionSet = RickAndMortyQueries_MutableSelectionSet

  typealias MutableInlineFragment = RickAndMortyQueries_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Query": return RickAndMortyQueries.Objects.Query
      case "Character": return RickAndMortyQueries.Objects.Character
      case "Location": return RickAndMortyQueries.Objects.Location
      case "Episode": return RickAndMortyQueries.Objects.Episode
      case "Characters": return RickAndMortyQueries.Objects.Characters
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}