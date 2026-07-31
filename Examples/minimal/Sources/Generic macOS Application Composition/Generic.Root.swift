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
    /// What the generic application is composed into: nothing.
    ///
    /// A real composition root holds the process resources phase one constructed —
    /// clients, pools, connections — and is the value every boundary resolves. This
    /// one holds none, which is the point: the shell must work when the root is
    /// empty, or the shell is carrying domain assumptions.
    public struct Root: Sendable, Hashable {
        /// Creates the empty root.
        public init() {}
    }
}
