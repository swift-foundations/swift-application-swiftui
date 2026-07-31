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

public import Environment

/// The core's `Environment.Snapshot`, aliased under a name that does not collide.
///
/// `swift-environment`'s namespace enum is itself named `Environment`, so its
/// canonical spelling `Environment.Snapshot` is only unambiguous in a file that does
/// not also import SwiftUI. Every other file in this module does — SwiftUI exports its
/// own `Environment` property wrapper at the same unqualified name, and the leading
/// identifier resolves to that type rather than to this module, so even the
/// fully module-qualified spelling fails to compile from such a file. This file is the
/// one place in the module that imports `Environment` without also importing SwiftUI,
/// so the reference here is unambiguous; the alias carries that resolved answer to
/// every other file without asking it to repeat the disambiguation.
public typealias EnvironmentSnapshot = Environment.Snapshot
