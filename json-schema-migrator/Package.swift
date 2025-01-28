// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "json-schema-migrator",
    platforms: [.macOS(.v11)],
    targets: [
        .executableTarget(
            name: "JsonSchemaMigrator",
            dependencies: ["JsonSchemaMigratorKit"]),
        .target(
            name: "JsonSchemaMigratorKit"),
        .testTarget(
            name: "JsonSchemaMigratorTests",
            dependencies: ["JsonSchemaMigratorKit"]
        )
    ]
)
