// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "shared",
    products: [
        .library(
            name: "DataLoggingSDK",
            targets: ["DataLoggingSDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-java", branch: "main")
    ],
    targets: [
        .target(
            name: "DataLoggingSDK",
            dependencies: [
                .product(name: "SwiftKitSwift", package: "swift-java")
            ],
            exclude: [
                "swift-java.config"
            ],
            plugins: [
                .plugin(name: "JExtractSwiftPlugin", package: "swift-java")
            ])
    ]
)
