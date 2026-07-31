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

extension Generic {
    /// The generic application's shell.
    ///
    /// Conformance lives in `Generic.Runtime+Application.Runtime.Scene.swift`, and
    /// reading it is the point of this target: four declarations — the root, the
    /// failure domain, how to boot, what to present — and every other question the
    /// application contract asks is already answered by
    /// ``Application/Runtime/Scene/Protocol``.
    public enum Runtime {}
}
