// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "swift-application-swiftui",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Application SwiftUI",
            targets: ["Application SwiftUI"]
        ),
        .executable(
            name: "generic-macos-application",
            targets: ["Generic macOS Application"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-foundations/swift-application.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-environment.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Application SwiftUI",
            dependencies: [
                .product(name: "Application", package: "swift-application"),
                .product(name: "Environment", package: "swift-environment"),
            ]
        ),

        // The Goal's first observable outcome. The composition target owns the
        // root and the runtime conformance; the executable is the shim over it.
        .target(
            name: "Generic macOS Application Composition",
            dependencies: [
                "Application SwiftUI",
            ]
        ),
        .executableTarget(
            name: "Generic macOS Application",
            dependencies: [
                "Generic macOS Application Composition",
            ]
        ),

        .testTarget(
            name: "Application SwiftUI Tests",
            dependencies: [
                "Application SwiftUI",
                "Generic macOS Application Composition",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
