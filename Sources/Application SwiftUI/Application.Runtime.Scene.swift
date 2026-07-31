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

extension Application.Runtime {
    /// Namespace for the runtime whose execution context is a SwiftUI scene host.
    ///
    /// ``Application/Runtime/Protocol`` says what any shell must answer; this
    /// namespace holds the answers that are specific to being hosted by SwiftUI on
    /// an Apple platform — how scenes are described
    /// (``Application/Runtime/Scene/Protocol``), how the process is entered
    /// (``__ApplicationRuntimeSceneProtocol/launch()``), and what actually owns the
    /// process while it runs (``Application/Runtime/Scene/Host``).
    ///
    /// The namespace is deliberately not called after the vendor. `SwiftUI` as a
    /// nested name would shadow the `SwiftUI` module inside every extension in this
    /// target, and the concept being named here is the scene, not the framework.
    public enum Scene {}
}
