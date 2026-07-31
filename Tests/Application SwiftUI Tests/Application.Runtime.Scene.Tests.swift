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

import Application_SwiftUI
import Testing

extension Application.Runtime.Scene {
    @Suite
    struct Test {
        /// The table is asserted against the default the scene protocol itself
        /// supplies, since this package has no conformer of its own — a conformer
        /// that overrode it is the example's concern, not this library's.
        @Test
        func everyBoundaryReappliesTheRoot() {
            #expect(Application.Boundary.Table.reapplied.boundaries(.inherited).isEmpty)
        }
    }
}
