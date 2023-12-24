import ProjectDescription

let project = Project(
    name: "RickAndMortyFanApp",
    packages: [
            .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.5.6")),
            .remote(url: "https://github.com/apollographql/apollo-ios.git", requirement: .upToNextMajor(from: "1.7.1"))
        ],
    targets: [
        Target(
            name: "RickAndMoryFanApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.roya1.rickAndMortyFanApp",
            infoPlist: .default,
            sources: [
                "Sources/**",
                "GraphQL/Sources/**"
            ],
            dependencies: [
                .package(product: "ComposableArchitecture", type: .macro),
                .package(product: "ComposableArchitecture"),
                .package(product: "Apollo"),
                TargetDependency.target(name: "RickAndMortyQueries")
            ]
        ),
        Target(
            name: "RickAndMortyQueries",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.roya1.rickAndMortyQueries",
            sources: [
                "GraphQL/Sources/**"
            ],
            dependencies: [
                .package(product: "Apollo")
            ]
        )
    ]
)
