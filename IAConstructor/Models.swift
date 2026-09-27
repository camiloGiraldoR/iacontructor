//
//  Models.swift
//  IAConstructor
//
//  Data models for the application
//

import Foundation

enum ProjectType: String, CaseIterable {
    case house = "Casa"
    case building = "Edificio"
    case office = "Oficina"
}

enum AnalysisType: String, CaseIterable {
    case floor = "Piso"
    case window = "Ventana"
    case wall = "Muro"
}

enum ConstructionStage: String, CaseIterable {
    case roughIn = "Obra Negra"
    case grayStructure = "Obra Gris"
    case finished = "Obra Blanca"
}

struct Project: Identifiable {
    let id = UUID()
    var name: String
    var address: String
    var responsiblePerson: String
    var type: ProjectType
    var numberOfFloors: Int
    var createdAt: Date = Date()
    var floors: [Floor] = []
}

struct Floor: Identifiable {
    let id = UUID()
    var number: Int
    var spaces: [Space] = []
}

struct Space: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var createdAt: Date = Date()
    var analyses: [Analysis] = []
}

struct Analysis: Identifiable {
    let id = UUID()
    var type: AnalysisType
    var width: Double
    var height: Double
    var area: Double
    var stage: ConstructionStage
    var materials: [String: String] = [:]
    var createdAt: Date = Date()
}
