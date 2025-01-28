import Foundation
import JsonSchemaMigratorKit
import ArgumentParser

@main
struct Math: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A utility for migrating json files.",
        subcommands: [Log.self, Migrate.self],
        defaultSubcommand: Log.self)

    struct JsonSchemas: ParsableArguments {

        @Argument(help: "Path to the old json schema.")
        var oldSchema: String

        @Argument(help: "Path to the new json schema.")
        var newSchema: String
    }

    struct Log: ParsableCommand {
        static let configuration
            = CommandConfiguration(abstract: "Print the changes between two json schemas.")

        @OptionGroup var schemas: JsonSchemas

        func run() throws {
            let old = try readSchema(from: schemas.oldSchema)
            let new = try readSchema(from: schemas.newSchema)
            compare(old, new)
        }

        private func compare(_ old: JsonSchema, _ new: JsonSchema) {
            let changes = compareProperties(old.properties, new.properties, path: [])

            for change in changes {
                switch change.kind {
                case .deletedProperty(let string):
                    print("\(change.path): Deleted \(string)")
                case .addedProperty(let string, let property):
                    print("\(change.path): Added property \(string) - \(property)")
                case .deletedItem:
                    print("\(change.path): Deleted item")
                case .addedItem(let property):
                    print("\(change.path): Added item - \(property)")
                case .changeType(let jsonType):
                    print("\(change.path): Changed type - \(jsonType)")
                }
            }
        }


    }
}
func readSchema(from filePath: String) throws -> JsonSchema {
    let data = try Data(contentsOf: URL(filePath: filePath))
    return try JSONDecoder().decode(JsonSchema.self, from: data)
}

