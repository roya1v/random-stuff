import Foundation
import JsonSchemaMigratorKit

@main
struct JsonSchemaMigrator {

    static func main() throws {
        let old = try JSONDecoder().decode(JsonSchema.self, from: try Data(contentsOf: URL("./Example/old_schema.json")!))
        let new = try JSONDecoder().decode(JsonSchema.self, from: try Data(contentsOf: URL("./Example/new_schema.json")!))
        compare(old, new)
    }

    static func compare(_ old: JsonSchema, _ new: JsonSchema) {
        let changes = compareProperties(old.properties, new.properties, path: "")

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
