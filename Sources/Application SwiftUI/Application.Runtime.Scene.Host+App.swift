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

public import SwiftUI

extension Application.Runtime.Scene.Host: SwiftUI.App {
    /// The runtime's scenes, evaluated inside the scene boundary.
    ///
    /// Routing the evaluation through ``__ApplicationRuntimeProtocol/enter(_:operation:)``
    /// rather than calling `Runtime.body(root)` directly is what makes the boundary
    /// table behaviour instead of documentation: a runtime that declares
    /// ``Application/Boundary/scene`` re-applied gets the root and its registered
    /// dependency values re-established here, on every evaluation.
    public var body: some SwiftUI.Scene {
        Runtime.enter(.scene) {
            Runtime.body(root)
        }
    }
}
