# swift-application-swiftui

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

The Apple-client shell for Swift — SwiftUI scene and lifecycle binding over the engine-free application core, so a client and a server are the same application under different composition roots.

---

## Key Features

- **One shell for every Apple platform** — macOS, iOS, tvOS, watchOS and visionOS share SwiftUI, so they share a shell. A per-OS split would be a boundary along the wrong axis; where a platform genuinely differs, that difference gets its own target inside this package.
- **A runtime states four things** — its root, its failure domain, how it boots, and its scenes. How boundaries obtain the root and what running means have the same answer for every SwiftUI host, so `Application.Runtime.Scene.Protocol` answers them once.
- **The boundary table is behaviour** — every scene body evaluation is routed through the scene boundary, so a re-applied root and its registered dependency values are in force on the second evaluation as well as the first.
- **The vendor surface is one type** — `Application.Runtime.Scene.Host` is the only thing in this package SwiftUI can see. The vocabulary a runtime is described in stays engine-free, and nothing platform-shaped leaks down into the cores this package composes.
- **Boot happens before the run loop** — the two-phase boot completes and the composition root is registered before the scene host is started, so no boundary can open against an unregistered root.

## Quick Start

Describe the application in a composition target:

```swift
import Application_SwiftUI
import Environment
import SwiftUI

enum Runtime: Application.Runtime.Scene.`Protocol` {
    typealias Failure = Never

    // Phase one and two: construct process resources, compose the root.
    static func boot(_ environment: Environment.Snapshot) async -> Root {
        Root(greeting: environment.string("GREETING") ?? "hello")
    }

    static func body(_ root: Root) -> some SwiftUI.Scene {
        WindowGroup {
            Text(root.greeting)
        }
    }
}
```

The executable is then the shim over it:

```swift
@main
enum Entry {
    @MainActor
    static func main() {
        Runtime.launch()
    }
}
```

`launch()` boots, registers the root, and hands the process to the scene host — in that order, and without returning.

## Documentation

The package is documented through DocC. `Application.Runtime.Scene` is the entry point.

## Design attribution

The application-as-value design this shell realizes is an independent Elm-lineage implementation composed on existing Institute owners; it is a recreation rather than a fork.

## License

Apache License 2.0. See [LICENSE.md](LICENSE.md).
