import Vapor

func routes(_ app: Application) throws {
    app.get("api", "available") { _ async -> [String] in
        []
    }
}
