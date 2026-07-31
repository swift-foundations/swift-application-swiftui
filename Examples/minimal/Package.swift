// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "generic-macos-application",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
    ],
    products: [
        .library(
            name: "Generic macOS Application Composition",
            targets: ["Generic macOS Application Composition"]
        ),
    ],
    dependencies: [
        .package(path: "../..")
    ],
    targets: [
        // The example's whole domain-specific surface: the root and the runtime
        // conformance. Owned here, not by the parent library, because it composes
        // one example rather than describing the shell family the parent defines.
        // Exposed as a library for the sibling Xcode app target, which carries the
        // example's single @main entry and zero domain logic of its own.
        .target(
            name: "Generic macOS Application Composition",
            dependencies: [
                .product(name: "Application SwiftUI", package: "swift-application-swiftui"),
            ]
        ),

        .testTarget(
            name: "Generic macOS Application Composition Tests",
            dependencies: [
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

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
