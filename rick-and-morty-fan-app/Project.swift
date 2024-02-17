import ProjectDescription

let project = Project(
    name: "RickAndMortyFanApp",
    packages: [
            .remote(url: "https://github.com/apollographql/apollo-ios.git", requirement: .upToNextMajor(from: "1.7.1"))
        ],
    targets: [
        Target(
            name: "RickAndMoryFanApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.roya1.rickAndMortyFanApp",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: [
                "Sources/**",
                "GraphQL/Sources/**"
            ],
            dependencies: [
                .package(product: "Apollo"),
                .target(name: "RickAndMortyQueries")
            ]
        ),
        Target(
            name: "RickAndMortyQueries",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.roya1.rickAndMortyQueries",
            deploymentTargets: .iOS("17.0"),
            sources: [
                "GraphQL/Sources/**"
            ],
            dependencies: [
                .package(product: "Apollo")
            ]
        )
    ]
)
