// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "shared",
    products: [
        .library(
            name: "DataLoggingSDK",
            targets: ["DataLoggingSDK"]),
    ],
    targets: [
        .target(
            name: "DataLoggingSDK"),
    ]
)
