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

/// Namespace for the generic macOS application.
///
/// The application composed of nothing. It exists to demonstrate that the shell is
/// complete — that an application can be expressed as a composition root plus a
/// scene description, with no domain logic anywhere — and to keep that claim under
/// CI rather than in prose.
///
/// Everything a real application would add goes in ``Generic/Root``. Everything a
/// real application would present goes in the scenes
/// ``Generic/Runtime`` describes. That is the entire seam.
public enum Generic {}
