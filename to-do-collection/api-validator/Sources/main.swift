import Foundation

if #available(macOS 12.0, *) {
    print("Hello, world!")

    let session = URLSession.shared

    var request = URLRequest(url: URL(string: "http://localhost:8080/api/available")!)

    let (resp, data) = try await session.data(for: request)

    guard let content = try? JSONDecoder().decode([String].self, from: resp) else {
        fatalError()
    }
    print(content)
}
