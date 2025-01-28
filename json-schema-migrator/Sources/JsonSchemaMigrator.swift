import Foundation

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

    static func compareProperties(_ old: JsonSchema.Properties, _ new: JsonSchema.Properties, path: String) -> [Change] {
        guard old != new else {
            return []
        }
        var result = [Change]()

        for (propertyName, oldProperty) in old {
            if let newProperty = new[propertyName] {
                result.append(contentsOf: comprateProperty(oldProperty, newProperty, path: "\(path)/\(propertyName)"))
            } else {
                result.append(.init(path: path, kind: .deletedProperty(propertyName)))
            }
        }

        for (propertyName, newProperty) in new {
            if old[propertyName] == nil {
                result.append(.init(path: path, kind: .addedProperty(propertyName, newProperty)))
            }
        }
        return result
    }

    static func comprateProperty(_ old: JsonSchema.Property, _ new: JsonSchema.Property, path: String) -> [Change] {
        guard old != new else {
            return []
        }
        var result = [Change]()

        if old.type != new.type {
            result.append(.init(path: path, kind: .changeType(new.type)))
        }

        if old.item != new.item {
            if let newItem = new.item {
                if let oldItem = old.item {
                    result.append(contentsOf: comprateProperty(oldItem, newItem, path: path))
                } else {
                    result.append(.init(path: path, kind: .addedItem(newItem)))
                }
            } else if old.item != nil {
                result.append(.init(path: path, kind: .deletedItem))
            }
        }

        if old.properties != new.properties {
            if let newProperties = new.properties {
                if let oldProperties = old.properties {
                    result.append(contentsOf: compareProperties(oldProperties, newProperties, path: path))
                } else {
                    for (propertyName, property) in newProperties {
                        result.append(.init(path: path, kind: .addedProperty(propertyName, property)))
                    }
                }
            } else if let oldProperties = old.properties {
                for (propertyName, _) in oldProperties {
                    result.append(.init(path: path, kind: .deletedProperty(propertyName)))
                }
            }
        }

        return result
    }
}

struct Change {
    enum Kind {
        case deletedProperty(String)
        case addedProperty(String, JsonSchema.Property)

        case deletedItem
        case addedItem(JsonSchema.Property)

        case changeType(JsonSchema.Property.JsonType)
    }

    let path: String
    let kind: Kind
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
