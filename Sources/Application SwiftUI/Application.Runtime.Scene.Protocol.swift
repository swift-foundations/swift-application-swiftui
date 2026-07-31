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

public import Dispatch
public import Environment
public import SwiftUI
public import Synchronization

/// The lifecycle contract of a shell whose execution context is a SwiftUI scene host.
///
/// Declared at module scope and reached through ``Application/Runtime/Scene/Protocol``.
///
/// It refines ``Application/Runtime/Protocol`` by adding exactly one requirement —
/// what the application looks like as scenes — and by answering, once and for the
/// whole Apple client family, the two questions every shell must answer but which
/// have the same answer for all of them: how boundaries obtain the root, and what
/// running means.
///
/// A conformer therefore states its root, its failure domain, how it boots, and its
/// scenes. Nothing else.
public protocol __ApplicationRuntimeSceneProtocol: __ApplicationRuntimeProtocol {
    /// The application described as scenes.
    associatedtype Body: SwiftUI.Scene

    /// The scenes this application presents.
    ///
    /// Evaluated by SwiftUI, on the main actor, inside the
    /// ``Application/Boundary/scene`` boundary — see
    /// ``Application/Runtime/Scene/Host``.
    @MainActor
    @SwiftUI.SceneBuilder
    static func body(_ root: Root) -> Body
}

extension Application.Runtime.Scene {
    /// The lifecycle contract of a shell hosted by SwiftUI.
    public typealias `Protocol` = __ApplicationRuntimeSceneProtocol
}

// MARK: - Boundaries

extension __ApplicationRuntimeSceneProtocol {
    /// Every boundary re-applies the root.
    ///
    /// This is not a conservative default; it is the only truthful table for a
    /// SwiftUI host. ``Application/Boundary/Disposition/inherited`` describes a
    /// boundary that runs nested inside the scope carrying the root, and no boundary
    /// SwiftUI opens does. Scene bodies are evaluated by the framework's own
    /// invalidation machinery, `.task` modifiers start their own tasks, and
    /// background work is scheduled by the system — all of them detached from
    /// whatever scope boot ran in.
    ///
    /// The re-application is therefore per *evaluation*, not once per scene: a scene
    /// body re-evaluated after invalidation re-enters the boundary, which is what
    /// keeps the dependency values captured at registration in force for the second
    /// evaluation as well as the first.
    public static var boundaries: Application.Boundary.Table {
        .reapplied
    }
}

// MARK: - Lifecycle

extension __ApplicationRuntimeSceneProtocol {
    /// Running a SwiftUI application means handing the process to the scene host.
    ///
    /// Does not return: the host owns the run loop until the process terminates.
    public static func run(_ root: Root) async throws(Failure) {
        await Application.Runtime.Scene.Host<Self>.main()
    }

    /// Nothing to release by default.
    ///
    /// A SwiftUI host does not reach here — ``run(_:)`` does not return — so a
    /// conformer that has process resources to release wires them to the
    /// ``Application/Boundary/shutdown`` boundary rather than overriding this.
    public static func shutdown(_ root: Root) async throws(Failure) {}
}

// MARK: - Entry

extension __ApplicationRuntimeSceneProtocol {
    /// Boots the application, registers the root, and hands the process to the
    /// scene host. Does not return.
    ///
    /// This is the Apple-client entry point, and it exists instead of the inherited
    /// ``__ApplicationRuntimeProtocol/start()`` for a specific reason. `start()` is
    /// `async`, so reaching it requires an `async` `main`, which installs Swift
    /// Concurrency's main-actor drain as the owner of the main thread. A SwiftUI
    /// host expects to install *its* run loop there instead, and the two do not
    /// compose: whichever runs second is starved by the first.
    ///
    /// So the two-phase boot is performed here synchronously, before the run loop
    /// exists and while blocking the main thread is harmless because nothing is
    /// pumping it yet. The order is the contract's own — construct and compose,
    /// then register, then run — and no boundary can open before registration,
    /// because the host that opens them is started on the last line.
    ///
    /// A failure in any of the three steps is terminal by construction: there is no
    /// application to present, and no UI in which to report that. Each is reported
    /// as a trap naming which step failed rather than as a thrown error nobody could
    /// catch.
    @MainActor
    public static func launch() -> Never {
        let booted = Mutex<Swift.Result<Root, Failure>?>(nil)
        let finished = DispatchSemaphore(value: 0)

        // Detached on purpose: boot must not inherit the main thread this call is
        // about to block, and it must not inherit an ambient scope either — the
        // dependency values it establishes are captured at registration.
        Task.detached {
            let outcome: Swift.Result<Root, Failure>

            // `do throws(Failure)` is required for the catch to bind `Failure`; an
            // unannotated `do` binds `any Error`.
            do throws(Failure) {
                // Module-qualified: SwiftUI exports an `Environment` property
                // wrapper, so the bare namespace is ambiguous wherever both are
                // imported. Qualifying at the use site is the sanctioned fix;
                // renaming the namespace is not.
                outcome = .success(try await boot(Environment.Environment.Snapshot.effective()))
            } catch {
                outcome = .failure(error)
            }

            booted.withLock { $0 = outcome }
            finished.signal()
        }

        finished.wait()

        guard let outcome = booted.withLock({ $0 }) else {
            Swift.fatalError("boot signalled completion without recording an outcome")
        }

        let root: Root
        switch outcome {
        case .success(let value):
            root = value

        case .failure(let error):
            Swift.fatalError("application boot failed: \(error)")
        }

        do throws(Application.Composition.Error) {
            try Composition.register(root)
        } catch {
            Swift.fatalError("composition root could not be registered: \(error)")
        }

        Application.Runtime.Scene.Host<Self>.main()

        Swift.fatalError("the scene host returned")
    }
}
