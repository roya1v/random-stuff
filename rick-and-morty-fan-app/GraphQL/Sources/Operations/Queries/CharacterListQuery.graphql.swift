// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension RickAndMortyQueries {
  class CharacterListQuery: GraphQLQuery {
    public static let operationName: String = "CharacterList"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query CharacterList($page: Int) { characters(page: $page) { __typename results { __typename id name image gender species status type } } }"#
      ))

    public var page: GraphQLNullable<Int>

    public init(page: GraphQLNullable<Int>) {
      self.page = page
    }

    public var __variables: Variables? { ["page": page] }

    public struct Data: RickAndMortyQueries.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyQueries.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("characters", Characters?.self, arguments: ["page": .variable("page")]),
      ] }

      /// Get the list of all characters
      public var characters: Characters? { __data["characters"] }

      /// Characters
      ///
      /// Parent Type: `Characters`
      public struct Characters: RickAndMortyQueries.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyQueries.Objects.Characters }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("results", [Result?]?.self),
        ] }

        public var results: [Result?]? { __data["results"] }

        /// Characters.Result
        ///
        /// Parent Type: `Character`
        public struct Result: RickAndMortyQueries.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { RickAndMortyQueries.Objects.Character }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RickAndMortyQueries.ID?.self),
            .field("name", String?.self),
            .field("image", String?.self),
            .field("gender", String?.self),
            .field("species", String?.self),
            .field("status", String?.self),
            .field("type", String?.self),
          ] }

          /// The id of the character.
          public var id: RickAndMortyQueries.ID? { __data["id"] }
          /// The name of the character.
          public var name: String? { __data["name"] }
          /// Link to the character's image.
          /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
          public var image: String? { __data["image"] }
          /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
          public var gender: String? { __data["gender"] }
          /// The species of the character.
          public var species: String? { __data["species"] }
          /// The status of the character ('Alive', 'Dead' or 'unknown').
          public var status: String? { __data["status"] }
          /// The type or subspecies of the character.
          public var type: String? { __data["type"] }
        }
      }
    }
  }

}