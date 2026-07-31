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

extension Counter {
    /// What the counter is.
    public struct State: Sendable, Hashable {
        /// The current count.
        public var count: Int

        /// Creates a counter at `count`.
        public init(count: Int = 0) {
            self.count = count
        }
    }
}
