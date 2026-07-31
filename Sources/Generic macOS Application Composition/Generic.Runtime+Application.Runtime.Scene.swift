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

public import Application_SwiftUI
public import Environment
public import SwiftUI

extension Generic.Runtime: Application.Runtime.Scene.`Protocol` {
    public typealias Root = Generic.Root

    /// Nothing can fail: there is nothing to construct.
    public typealias Failure = Never

    /// Phase one and two, for an application with no process resources.
    ///
    /// The environment is accepted and ignored — deliberately. A real root reads it
    /// here, which is why it is passed in rather than read from the process: a test
    /// boots the same code against a snapshot it controls.
    /// Module-qualified: SwiftUI exports an `Environment` property wrapper, so the
    /// bare namespace is ambiguous wherever both are imported.
    public static func boot(_ environment: Environment.Environment.Snapshot) async -> Generic.Root {
        Generic.Root()
    }

    /// One empty window.
    public static func body(_ root: Generic.Root) -> some SwiftUI.Scene {
        SwiftUI.WindowGroup {
            SwiftUI.EmptyView()
        }
    }
}
