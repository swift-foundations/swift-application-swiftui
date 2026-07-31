// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-application-swiftui open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-application-swiftui project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

internal import Application_SwiftUI
internal import Generic_macOS_Application_Composition

/// The generic macOS application, installed and launched through Xcode.
///
/// The whole app target, and the example's only entry point. It names a runtime and
/// hands the process to the shell; everything else — boot, registration, the boundary
/// table, the run loop — is the shell's, and everything about *this* application is
/// the composition target's, in the nested SwiftPM package this target depends on.
/// It lives in the Xcode target rather than a SwiftPM executable because `@main`
/// must be declared in the target Xcode installs and launches.
@main
internal enum Entry {
    @MainActor
    internal static func main() {
        Generic.Runtime.launch()
    }
}
