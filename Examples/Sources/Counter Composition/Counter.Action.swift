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
    /// What can happen to the counter.
    ///
    /// Cases name what occurred, never what to do about it: ``resetRequested`` is
    /// the user asking, ``reset`` is the effect reporting back. Keeping the two
    /// apart is what lets the update stay a pure function of state and action.
    public enum Action: Sendable, Hashable {
        /// The user incremented the counter.
        case incremented

        /// The user decremented the counter.
        case decremented

        /// The user asked for the counter to be reset shortly.
        case resetRequested

        /// The delay elapsed.
        case reset
    }
}
