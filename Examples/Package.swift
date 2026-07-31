// swift-tools-version: 6.3.3

import PackageDescription

// A nested package, so the examples stay off the shell's product surface entirely
// while still being built from the same checkout. `.package(path: "..")` is the one
// sanctioned path-form dependency — the same shape the ecosystem's nested test
// packages use.
let package = Package(
    name: "swift-application-swiftui-examples",
    platforms: [
        .macOS(.v26)
    ],
    products: [
        .executable(
            name: "counter",
            targets: ["Counter"]
        ),
    ],
    dependencies: [
        .package(path: ".."),
    ],
    targets: [
        // Everything about this application: its state, how it changes, what it
        // renders, and what it is composed into.
        .target(
            name: "Counter Composition",
            dependencies: [
                .product(name: "Application SwiftUI", package: "swift-application-swiftui"),
            ]
        ),

        // The shim. Generic, and identical to the one the empty application uses.
        .executableTarget(
            name: "Counter",
            dependencies: [
                "Counter Composition",
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
