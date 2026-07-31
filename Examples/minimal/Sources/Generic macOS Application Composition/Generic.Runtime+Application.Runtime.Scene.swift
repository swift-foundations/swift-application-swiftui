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
    /// `EnvironmentSnapshot`, not `Environment.Snapshot`: SwiftUI's own `Environment`
    /// property wrapper collides with the core's namespace at the same unqualified
    /// name, so this file references the alias resolved once in `Application_SwiftUI`
    /// rather than repeating the disambiguation — see `EnvironmentSnapshot.swift`.
    public static func boot(_ environment: EnvironmentSnapshot) async -> Generic.Root {
        Generic.Root()
    }

    /// One empty window.
    public static func body(_ root: Generic.Root) -> some SwiftUI.Scene {
        SwiftUI.WindowGroup {
            SwiftUI.EmptyView()
        }
    }
}
