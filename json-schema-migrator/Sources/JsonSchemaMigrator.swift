import Foundation

@main
struct JsonSchemaMigrator {

    static func main() throws {
        let old = try JSONDecoder().decode(JsonSchema.self, from: try Data(contentsOf: URL("./Example/old_schema.json")!))
        let new = try JSONDecoder().decode(JsonSchema.self, from: try Data(contentsOf: URL("./Example/new_schema.json")!))
        compare(old, new)
    }

    static func compare(_ old: JsonSchema, _ new: JsonSchema) {
        for (oldPropertyName, oldProperty) in old.properties {
            if let newSchemaProperty = new.properties[oldPropertyName] {
                if newSchemaProperty != oldProperty {
                    print("Property '\(oldPropertyName)' changed from \(oldProperty) to \(newSchemaProperty)")
                }
            } else {
                print("Property '\(oldPropertyName) deleted")
            }
        }

        for (newPropertyName, newProperty) in new.properties {
            if old.properties[newPropertyName] == nil {
                debugPrint("New property '\(newPropertyName)' is \(newProperty)")
            }
        }
    }

}

enum Change {
    case newProperty(name: String, property: JsonSchema.Property)
}

struct JsonSchema: Codable {
    typealias Properties = [String: Property]
    let properties: Properties

    struct Property: Codable, Equatable {
        let type: JsonType

        enum JsonType: String, Codable, CustomDebugStringConvertible {
            case string
            case object
            case array
            case integer

            var debugDescription: String {
                self.rawValue
            }
        }
    }
}
