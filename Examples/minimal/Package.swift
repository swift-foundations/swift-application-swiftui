// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "generic-macos-application",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
    ],
    products: [
        .executable(
            name: "generic-macos-application",
            targets: ["Generic macOS Application"]
        ),
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
        // Exposed as a library so both the SwiftPM executable below and the sibling
        // Xcode app target — which must carry zero domain logic of its own — can
        // depend on the same composition.
        .target(
            name: "Generic macOS Application Composition",
            dependencies: [
                .product(name: "Application SwiftUI", package: "swift-application-swiftui"),
            ]
        ),

        // The shim, in full: names a runtime and hands the process to it. Kept as
        // a plain SwiftPM executable for `swift run` on any platform SwiftPM
        // targets directly; the Xcode app target beside this package is the same
        // shim again, for platforms only Xcode can install and launch (the iOS
        // Simulator).
        .executableTarget(
            name: "Generic macOS Application",
            dependencies: [
                "Generic macOS Application Composition",
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
