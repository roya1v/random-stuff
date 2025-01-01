import Foundation

public final class DataLogger {

    private var data = [String]()

    public init() { }

    public func start() {
        data.append("Hello, World!")
    }

    public func stop() {
        fatalError("Stop not implemented")
    }
}
