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

### Navigation Flow (Type-Safe with NavigationStack)

The app uses a centralized routing system via `NavigationScreen` enum for type-safe navigation:

```
WelcomeView
  ↓
ProjectListView
  ├── CreateProjectView → ProjectDetailView
  └── ProjectDetailView
       ├── FloorDetailView
       │    ├── CreateSpaceView
       │    └── SpaceDetail (with Analysis list)
       │         ├── SpaceTypeSelectView
       │         └── ScanningView
       │              ├── AnalysisResultView
       │              └── AnalysisSavedView
```

### Key Views
- **WelcomeView** — Entry point with LiDAR compatibility info and "Comencemos" button
- **ProjectListView** — Dashboard showing projects with metrics (03 Proyectos, 17 Espacios Scan)
- **CreateProjectView** — Form to create new projects with name, address, type, and number of floors
- **ProjectDetailView** — Shows [FICHA TÉCNICA] section and list of floors with analysis count
- **FloorDetailView** — Displays spaces in a floor with "MODO LIDAR 3D ACTIVO" status and individual space cards with "Ver Detalles" and "Analizar" buttons
- **CreateSpaceView** — Simple input for space name
- **SpaceTypeSelectView** — Three options: Piso (square), Ventana (window), Muro (wall)
- **ScanningView** — 3D visualization with measurement overlays (3.20 m, 2.85 m) and surface detection
- **AnalysisResultView** — Shows detected dimensions, construction stage selector (Negra/Gris/Blanca), and estimated materials
- **AnalysisSavedView** — Success screen with confirmation checklist
- **SpaceDetailView** — Displays space dossier and "Análisis Guardados" (list of past analyses with type, stage, measurements, and dates)

Data model uses SwiftData for local persistence. See the spec for the `ScannedSpace` model definition.

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
├── IAConstructorApp.swift                    # App entry point (@main)
├── ContentView.swift                         # Delegates to AppRootView
├── App/
│   └── AppRootView.swift                     # NavigationStack root with routing
├── Navigation/
│   └── NavigationRouter.swift                # NavigationScreen enum (type-safe routing)
├── Views/
│   ├── WelcomeView.swift                     # Entry screen with logo and intro
│   ├── ProjectListView.swift                 # Project dashboard with metrics
│   └── OtherViews.swift                      # All other views:
│       ├── CreateProjectView
│       ├── ProjectDetailView
│       ├── FloorDetailView
│       ├── CreateSpaceView
│       ├── SpaceTypeSelectView
│       ├── ScanningView
│       ├── AnalysisResultView
│       ├── AnalysisSavedView
│       └── SpaceDetailView
├── Models.swift                              # Data models (Project, Floor, Space, Analysis, etc.)
├── ToastView.swift                           # Toast notification component
├── Assets.xcassets/                          # App assets, icons, colors
└── docs/
    └── especificaci_n_del_proyecto_iaconstructor.md  # Full spec (Spanish)
```

## Navigation System

The app uses **type-safe navigation** with a centralized `NavigationScreen` enum:

```swift
enum NavigationScreen: Hashable {
    case welcome
    case projectList
    case createProject
    case projectDetail(String)           // projectID
    case floorDetail(String, Int)        // projectID, floorNumber
    case createSpace(String, Int)        // projectID, floorNumber
    case spaceTypeSelect(String, Int, String)    // projectID, floorNumber, spaceName
    case scanning(String, Int, String)           // projectID, floorNumber, spaceName
    case analysisResult(String, Int, String)     // projectID, floorNumber, spaceName
    case analysisSaved(String, Int, String)      // projectID, floorNumber, spaceName
    case spaceDetail(String, Int, String)        // projectID, floorNumber, spaceName
}
```

- `AppRootView` wraps a `NavigationStack` and maps each enum case to its corresponding view
- Views use `@Binding var navigationPath: [NavigationScreen]` to navigate
- Push: `navigationPath.append(.screen(params))`
- Pop: `navigationPath.removeLast()` or `navigationPath.removeLast(n)`

## Recommended Development Workflow

1. **Follow the navigation flow**: Start with WelcomeView → ProjectListView and progress through the hierarchy
2. **Test with previews first**: Use SwiftUI previews (`#Preview` blocks) before running on a simulator
3. **Design reusable sub-components**: Extract UI elements into smaller views within the same file (e.g., `ProjectCard`, `MetricBox`)
4. **Use mock data**: Each view includes `@State` or inline mock arrays to simulate data without persistence
5. **Device testing**: LiDAR features require testing on a compatible device (iPhone 12 Pro or newer, or iPad Pro)
6. **Planned: SwiftData integration**: Models are defined but persistence is not yet wired in — use mock data for now
