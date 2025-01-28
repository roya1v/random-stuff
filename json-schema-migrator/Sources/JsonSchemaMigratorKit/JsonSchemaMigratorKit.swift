import Foundation

public func compareProperties(_ old: JsonSchema.Properties, _ new: JsonSchema.Properties, path: [String]) -> [Change] {
    guard old != new else {
        return []
    }
    var result = [Change]()

    for (propertyName, oldProperty) in old {
        if let newProperty = new[propertyName] {
            result.append(contentsOf: comprateProperty(oldProperty, newProperty, path: path + [propertyName]))
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

public func comprateProperty(_ old: JsonSchema.Property, _ new: JsonSchema.Property, path: [String]) -> [Change] {
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

public struct Change: Equatable {
    public enum Kind: Equatable {
        case deletedProperty(String)
        case addedProperty(String, JsonSchema.Property)

        case deletedItem
        case addedItem(JsonSchema.Property)

        case changeType(JsonSchema.Property.JsonType)
    }

    public let path: [String]
    public let kind: Kind
}

public struct JsonSchema: Codable {
    public typealias Properties = [String: Property]
    public let properties: Properties

    public class Property: Codable, Equatable, CustomDebugStringConvertible {
        public let type: JsonType
        public let properties: Properties?
        public let item: Property?

        internal init(type: JsonSchema.Property.JsonType, properties: JsonSchema.Properties? = nil, item: JsonSchema.Property? = nil) {
            self.type = type
            self.properties = properties
            self.item = item
        }

        public static func == (lhs: JsonSchema.Property, rhs: JsonSchema.Property) -> Bool {
            lhs.item == rhs.item && lhs.properties == rhs.properties && lhs.type == rhs.type
        }

        public var debugDescription: String {
            var string = ["type: \(type)"]
            if let properties {
                string.append("properties: \(properties)")
            }
            if let item {
                string.append("item: \(item)")
            }

            return "Property(\(string.joined(separator: ", ")))"
        }

        public enum JsonType: String, Codable, CustomDebugStringConvertible {
            case string
            case object
            case array
            case integer

            public var debugDescription: String {
                self.rawValue
            }
        }
    }
}
