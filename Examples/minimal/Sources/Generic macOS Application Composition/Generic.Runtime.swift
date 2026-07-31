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
    /// `Sendable` is declared here rather than left to the conformance in the
    /// companion file: the scene contract refines a `Sendable` protocol, and Swift
    /// requires an inherited `Sendable` conformance to occur in the same file as the
    /// type it applies to.
    public enum Runtime: Sendable {}
}
