import Foundation

public enum JsonValue: Codable {
    case object([String: JsonValue])
    case string(String)
    case integer(Int)
    case double(Double)
    case array([JsonValue])
    case boolean(Bool)
    case null

    public subscript(index: Int) -> JsonValue {
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

    public subscript(key: String) -> JsonValue? {
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

public extension JsonValue {
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
