// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "swift-copy-with",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "swiftCopyWith",
            targets: ["swiftCopyWith"]
        ),
        .executable(
            name: "swiftCopyWithClient",
            targets: ["swiftCopyWithClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ],
    targets: [
        .macro(
            name: "swiftCopyWithMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(name: "swiftCopyWith", dependencies: ["swiftCopyWithMacros"]),
        .executableTarget(name: "swiftCopyWithClient", dependencies: ["swiftCopyWith"]),
        .testTarget(
            name: "swiftCopyWithTests",
            dependencies: [
                "swiftCopyWithMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
