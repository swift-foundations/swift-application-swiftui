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

/// A counter.
///
/// The smallest application that still exercises every seam an application author
/// touches: state, an update that changes it, an effect that does asynchronous work
/// and feeds an action back, a view bound to the store, and a composition root the
/// shell resolves. Nothing here is shell machinery — that is the point of reading it.
public enum Counter: Sendable {}
