import Foundation

public func apply(_ change: Change, to json: inout JsonValue) {
    if let child = change.child,
       let pathComponent = change.path.first {
        print("/\(pathComponent)", terminator: "")
        apply(child, to: &json[pathComponent]!)
        return
    }
    print(": ", terminator: "")
    switch change.kind {
    case .deletedProperty(let propertyName):
        json[propertyName] = nil
        print("Deleted '\(propertyName)'")
    case .addedProperty(let propertyName, let property):
        addNewProperty(propertyName, property: property, json: &json)
    case .deletedItem:
        fatalError()
    case .addedItem(let property):
        fatalError()
    case .changeType(let jsonType):
        fatalError()
    }
}

private func addNewProperty(_ key: String, property: JsonSchema.Property, json: inout JsonValue) {
    print("Provide the default \(property.type) value for \(key)")
    guard let input = readLine() else {
        addNewProperty(key, property: property, json: &json)
        return
    }
    switch property.type {
    case .string:
        json[key] = .string(input)
    case .object:
        fatalError()
    case .array:
        fatalError()
    case .integer:
        guard let integer = Int(input) else {
            addNewProperty(key, property: property, json: &json)
            return
        }
        json[key] = .integer(integer)
    }
}
