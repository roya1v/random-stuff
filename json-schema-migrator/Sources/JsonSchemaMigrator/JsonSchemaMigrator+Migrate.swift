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

            print(json)

            let outputData = try JSONEncoder().encode(json)
            try outputData.write(to: URL(filePath: output))
        }

        private func apply(_ change: Change, to json: inout JsonValue) {
            switch change.kind {
            case .deletedProperty(let string):
                if let child = change.child {
                    apply(child, to: &json[change.path.first!]!)
                }
                json[string] = nil
            case .addedProperty(let string, let property):
                print("Provide the default value for \(string)")
                let test = readLine()!
                json[string] = .string(test)
            case .deletedItem:
                fatalError()
            case .addedItem(let property):
                fatalError()
            case .changeType(let jsonType):
                fatalError()
            }
        }
    }
}

enum JsonValue {
    case object([String: JsonValue])
    case string(String)
    case integer(Int)
    case double(Double)
    case array([JsonValue])
    case boolean(Bool)
    case null

    subscript(index: Int) -> JsonValue {
        get {
            guard case let .array(array) = self else {
                fatalError()
            }
            return array[index]
        }
        set(newValue) {
            guard case var .array(array) = self else {
                fatalError()
            }
            array[index] = newValue
            self = .array(array)
        }
    }

    subscript(key: String) -> JsonValue? {
        get {
            guard case let .object(dict) = self else {
                fatalError()
            }
            return dict[key]
        }
        set(newValue) {
            guard case var .object(dict) = self else {
                fatalError()
            }
            dict[key] = newValue
            self = .object(dict)
        }
    }
}

extension JsonValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let dict = try? container.decode([String: JsonValue].self) {
            self = .object(dict)
        } else if let arr = try? container.decode([JsonValue].self) {
            self = .array(arr)
        } else if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let int = try? container.decode(Int.self) {
            self = .integer(int)
        } else if let dbl = try? container.decode(Double.self) {
            self = .double(dbl)
        } else if let bool = try? container.decode(Bool.self) {
            self = .boolean(bool)
        } else {
            self = .null
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .object(let dict):
            try container.encode(dict.mapValues { $0 })
        case .string(let str):
            try container.encode(str)
        case .integer(let int):
            try container.encode(int)
        case .double(let double):
            try container.encode(double)
        case .array(let array):
            try container.encode(array)
        case .boolean(let bool):
            try container.encode(bool)
        case .null:
            try container.encodeNil()
        }
    }
}
