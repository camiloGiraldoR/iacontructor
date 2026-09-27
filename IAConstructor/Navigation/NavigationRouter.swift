//
//  NavigationRouter.swift
//  IAConstructor
//

import Foundation

enum NavigationScreen: Hashable {
    case welcome
    case projectList
    case createProject
    case projectDetail(String)
    case floorDetail(String, Int)
    case createSpace(String, Int)
    case spaceTypeSelect(String, Int, String)
    case scanning(String, Int, String)
    case analysisResult(String, Int, String)
    case analysisSaved(String, Int, String)
    case spaceDetail(String, Int, String)
}
