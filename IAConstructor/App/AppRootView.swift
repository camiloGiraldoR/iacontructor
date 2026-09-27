//
//  AppRootView.swift
//  IAConstructor
//

import SwiftUI

struct AppRootView: View {
    @State private var navigationPath: [NavigationScreen] = []

    var body: some View {
        NavigationStack(path: $navigationPath) {
            WelcomeView(navigationPath: $navigationPath)
                .navigationDestination(for: NavigationScreen.self) { screen in
                    NavigationDestinationView(screen: screen, navigationPath: $navigationPath)
                }
        }
    }
}

struct NavigationDestinationView: View {
    let screen: NavigationScreen
    @Binding var navigationPath: [NavigationScreen]

    var body: some View {
        switch screen {
        case .welcome:
            WelcomeView(navigationPath: $navigationPath)
        case .projectList:
            ProjectListView(navigationPath: $navigationPath)
        case .createProject:
            CreateProjectView(navigationPath: $navigationPath)
        case .projectDetail(let projectID):
            ProjectDetailView(navigationPath: $navigationPath, projectID: projectID)
        case .floorDetail(let projectID, let floorNumber):
            FloorDetailView(navigationPath: $navigationPath, projectID: projectID, floorNumber: floorNumber)
        case .createSpace(let projectID, let floorNumber):
            CreateSpaceView(navigationPath: $navigationPath, projectID: projectID, floorNumber: floorNumber)
        case .spaceTypeSelect(let projectID, let floorNumber, let spaceName):
            SpaceTypeSelectView(navigationPath: $navigationPath, projectID: projectID, floorNumber: floorNumber, spaceName: spaceName)
        case .scanning(let projectID, let floorNumber, let spaceName):
            ScanningView(navigationPath: $navigationPath, projectID: projectID, floorNumber: floorNumber, spaceName: spaceName)
        case .analysisResult(let projectID, let floorNumber, let spaceName):
            AnalysisResultView(navigationPath: $navigationPath, projectID: projectID, floorNumber: floorNumber, spaceName: spaceName)
        case .analysisSaved(let projectID, let floorNumber, let spaceName):
            AnalysisSavedView(navigationPath: $navigationPath, projectID: projectID, floorNumber: floorNumber, spaceName: spaceName)
        case .spaceDetail(let projectID, let floorNumber, let spaceName):
            SpaceDetailView(navigationPath: $navigationPath, projectID: projectID, floorNumber: floorNumber, spaceName: spaceName)
        }
    }
}

#Preview {
    AppRootView()
}
