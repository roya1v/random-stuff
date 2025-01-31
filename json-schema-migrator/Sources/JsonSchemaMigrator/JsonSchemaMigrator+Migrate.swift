import Foundation
import JsonSchemaMigratorKit
import ArgumentParser

extension Math {
    struct Migrate: ParsableCommand {
        static let configuration
        = CommandConfiguration(abstract: "Print the changes between two json schemas.")

        @OptionGroup var schemas: JsonSchemas

        @Argument(help: "Path to the json file to migrate.")
        var jsonFile: String

        @Option(help: "Path to the json file to migrate.")
        var output: String

        func run() throws {
            let old = try readSchema(from: schemas.oldSchema)
            let new = try readSchema(from: schemas.newSchema)

            let changes = compareProperties(old.properties, new.properties, path: [])

            let data = try Data(contentsOf: URL(filePath: jsonFile))

            var json = try JSONDecoder().decode(JsonValue.self, from: data)

            for change in changes {
                apply(change, to: &json)
            }

            let outputData = try JSONEncoder().encode(json)
            try outputData.write(to: URL(filePath: output))
        }
    }
}
