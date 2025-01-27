import Foundation

@main
struct JsonSchemaMigrator {

    static func main() throws {
        let old = try JSONDecoder().decode(JsonSchema.self, from: try Data(contentsOf: URL("./Example/old_schema.json")!))
        let new = try JSONDecoder().decode(JsonSchema.self, from: try Data(contentsOf: URL("./Example/new_schema.json")!))
        compare(old, new)
    }

    static func compare(_ old: JsonSchema, _ new: JsonSchema) {
        compareProperties(old.properties, new.properties)
    }

    static func compareProperties(_ old: JsonSchema.Properties, _ new: JsonSchema.Properties) {
        for (oldPropertyName, oldProperty) in old {
            if let newSchemaProperty = new[oldPropertyName] {
                if newSchemaProperty != oldProperty {
                    if let oldItem = oldProperty.item, let newItem = newSchemaProperty.item, oldItem != newItem {
                        compareProperties(oldItem.properties ?? [:],
                                          newItem.properties ?? [:])
                    } else {
                        debugPrint("Property '\(oldPropertyName)' changed from \(oldProperty) to \(newSchemaProperty)")
                    }
                }
            } else {
                debugPrint("Property '\(oldPropertyName) deleted")
            }
        }

        for (newPropertyName, newProperty) in new {
            if old[newPropertyName] == nil {
                debugPrint("New property '\(newPropertyName)' is \(newProperty)")
            }
        }
    }
}

struct JsonSchema: Codable {
    typealias Properties = [String: Property]
    let properties: Properties

    class Property: Codable, Equatable, CustomDebugStringConvertible {
        let type: JsonType
        let properties: Properties?
        let item: Property?

        static func == (lhs: JsonSchema.Property, rhs: JsonSchema.Property) -> Bool {
            lhs.item == rhs.item && lhs.properties == rhs.properties && lhs.type == rhs.type
        }

        var debugDescription: String {
            var string = ["type: \(type)"]
            if let properties {
                string.append("properties: \(properties)")
            }
            if let item {
                string.append("item: \(item)")
            }

            return "Property(\(string.joined(separator: ", ")))"
        }

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
