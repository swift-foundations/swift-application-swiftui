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
import Environment
import Generic_macOS_Application_Composition
import Testing

extension Application.Runtime.Scene {
    @Suite
    struct Test {
        /// The table is asserted against the whole shell, not against the default's
        /// own definition: a conformer that overrode it would still be reported here,
        /// which is the property worth holding.
        @Test
        func everyBoundaryReappliesTheRoot() {
            #expect(Generic.Runtime.boundaries == .reapplied)
            #expect(Generic.Runtime.boundaries.boundaries(.inherited).isEmpty)
        }

        /// Boot is passed a snapshot rather than reading the process, so this asserts
        /// the seam exists by exercising it with a snapshot the test owns.
        @Test
        func bootComposesARootFromASuppliedEnvironment() async {
            let root = await Generic.Runtime.boot(Environment.Snapshot([:]))

            #expect(root == Generic.Root())
        }
    }
}
