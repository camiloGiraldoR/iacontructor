# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**IAConstructor** is a native iOS application that serves as an intelligent assistant for the construction and renovation industry. It uses Apple's LiDAR technology and camera to measure dimensions in real-time and estimate material requirements.

See `IAConstructor/docs/especificaci_n_del_proyecto_iaconstructor.md` for the detailed project specification (in Spanish), including UI flow, data model, and tech stack.

## Building and Running

### Build the Project
```bash
xcodebuild -project IAConstructor.xcodeproj -scheme IAConstructor -configuration Debug
```

### Open in Xcode
```bash
open IAConstructor.xcodeproj
```

To run the app on a simulator or device, use Xcode's Run button (⌘R) or:
```bash
xcodebuild -project IAConstructor.xcodeproj -scheme IAConstructor -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Architecture

The app follows the planned navigation flow defined in the spec:
- **WelcomeView** → entry point (currently `ContentView.swift`)
- **ProjectDashboardView** → project management and space history
- **SpaceSelectorModal** → choose space type (Floor/Window/Wall)
- **ARScannerView** → LiDAR capture using ARKit + RoomPlan
- **SpaceSummaryView** → validate measurements and save with construction stage

Planned data model uses SwiftData for local persistence. See the spec for the `ScannedSpace` model definition.

## Tech Stack

| Layer | Technology | Purpose |
| --- | --- | --- |
| UI | **SwiftUI** | Reactive, native iOS interface |
| Scanning | **ARKit** + **RoomPlan** | LiDAR-based spatial detection and measurement |
| Storage | **SwiftData** | Local persistence of projects and scans |

## Key Development Notes

- **SwiftUI first**: All UI is built with SwiftUI. Use `@main` for the app entry point, `@Model` for SwiftData entities, and proper state management (`@State`, `@StateObject`, `@EnvironmentObject`).
- **LiDAR integration**: ARKit and RoomPlan frameworks are essential for measurement capture. Ensure device compatibility and proper permission handling for camera/LiDAR access.
- **Spanish localization**: UI strings are in Spanish (e.g., "Obra Negra", "Obra Gris", "Obra Blanca" for construction stages). Use localization where appropriate.
- **Preview-driven development**: Xcode previews are configured in SwiftUI files for rapid iteration on UI components.

## File Structure

```
IAConstructor/
├── IAConstructorApp.swift       # App entry point
├── ContentView.swift             # Welcome view (starting point)
├── Assets.xcassets/              # App assets, icons, colors
└── docs/
    └── especificaci_n_del_proyecto_iaconstructor.md  # Full spec (Spanish)
```

## Recommended Development Workflow

1. **Implement screens in order**: Follow the navigation flow from the spec.
2. **Test with previews first**: Use SwiftUI previews before running on a simulator.
3. **Use SwiftData migrations carefully**: Since data model evolves, plan schema changes early.
4. **Device testing**: LiDAR features require testing on a compatible device (iPhone 12 Pro or newer, or iPad Pro).
