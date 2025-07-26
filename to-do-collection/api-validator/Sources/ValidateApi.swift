import Foundation
import ArgumentParser

private let session = URLSession.shared

enum APISpec: String, Codable {
    case v1
}

struct TODOItem: Codable {
    let id: String
    let content: String
    let isDone: String

    enum CodingKeys: String, CodingKey {
        case id, content
        case isDone = "is_done"
    }
}

@main
struct ValidateApi: AsyncParsableCommand {
    @Argument
    var apiURL: String

    private var url: URL!

    mutating func run() async throws {
        guard let url = URL(string: apiURL) else {
            print("Invalid api url")
            return
        }

        self.url = url

        print("Validating todos api at \(url.absoluteString)")

        let availableAPIs = try await get([APISpec].self, fromPath: "api/available")

        print("Found the following API specs: \(availableAPIs)")

        for api in availableAPIs {
            switch api {
            case .v1:
                try await testV1()
            }
        }
    }

    private func get<T: Decodable>(_ model: T.Type, fromPath path: String) async throws -> T {
        var request = URLRequest(url: url.appending(path: path))

        let (data, resp) = try await session.data(for: request)
        let content = try JSONDecoder().decode(model, from: data)
        return content
    }

    private func testV1() async throws {
        print("Testing V1 API")
        let todos = try await get([TODOItem].self, fromPath: "api/v1/todos")

        print("Existing todos: \(todos)")
    }
}
