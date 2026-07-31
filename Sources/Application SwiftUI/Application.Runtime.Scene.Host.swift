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

extension Application.Runtime.Scene {
    /// The SwiftUI application that hosts a runtime's scenes.
    ///
    /// This is the whole vendor surface of the shell, and it is deliberately the
    /// only type in the package that SwiftUI can see. A runtime describes itself in
    /// the engine-free vocabulary of ``Application/Runtime/Protocol`` plus one
    /// scene-returning function; this type is what turns that description into
    /// something `SwiftUI.App` accepts.
    ///
    /// It is generic over the runtime rather than over the root, so the boundary
    /// table consulted when a scene body is evaluated is the runtime's own.
    public struct Host<Runtime: Application.Runtime.Scene.`Protocol`> {
        /// The composition root, resolved once when the host is constructed.
        ///
        /// Resolved here rather than per body evaluation because the root is
        /// registered exactly once and does not change; re-resolving on every
        /// invalidation would spend a lock to learn the same answer.
        internal let root: Runtime.Root

        /// Creates the host, resolving the composition root.
        ///
        /// SwiftUI constructs this type, so the initializer takes no arguments and
        /// reaches for the root itself. It is reached only from
        /// ``__ApplicationRuntimeSceneProtocol/launch()``, which registers the root
        /// on the line before, so a failure here is a composition defect rather than
        /// a runtime condition and there is no application in which to report it.
        @MainActor
        public init() {
            do throws(Application.Composition.Error) {
                self.root = try Runtime.root()
            } catch {
                Swift.fatalError("the scene host started before the composition root was registered: \(error)")
            }
        }
    }
}
