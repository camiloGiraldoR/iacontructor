//
//  OtherViews.swift
//  IAConstructor
//

import SwiftUI

struct CreateProjectView: View {
    @Binding var navigationPath: [NavigationScreen]
    @State private var projectName = ""
    @State private var projectAddress = ""
    @State private var selectedType = "Casa"
    @State private var numberOfFloors = "1"
    @State private var showToast = false

    let projectTypes = ["Casa", "Edificio", "Oficina"]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                if showToast {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                        Text("Proyecto creado satisfactoriamente")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(12)
                    .background(Color(red: 0.1, green: 0.12, blue: 0.15))
                    .cornerRadius(8)
                    .padding(16)
                }

                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Text("Nuevo Proyecto")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                ScrollView {
                    VStack(spacing: 20) {
                        FormField(label: "Nombre del Proyecto", placeholder: "Ej: Casa Residencial", text: $projectName)
                        FormField(label: "Dirección", placeholder: "Calle y número", text: $projectAddress)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tipo de Proyecto")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)

                            Picker("Tipo", selection: $selectedType) {
                                ForEach(projectTypes, id: \.self) { type in
                                    Text(type).tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                            .tint(Color(red: 0, green: 0.94, blue: 1))
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Número de Plantas")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)

                            HStack(spacing: 12) {
                                Button(action: {
                                    if let num = Int(numberOfFloors), num > 1 {
                                        numberOfFloors = String(num - 1)
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                        .frame(width: 44, height: 44)
                                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                        .cornerRadius(8)
                                }

                                Text(numberOfFloors)
                                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                    .frame(maxWidth: .infinity)

                                Button(action: {
                                    if let num = Int(numberOfFloors), num < 50 {
                                        numberOfFloors = String(num + 1)
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                        .frame(width: 44, height: 44)
                                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                        .cornerRadius(8)
                                }
                            }
                        }

                        Spacer().frame(height: 20)

                        Button(action: {
                            showToast = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                navigationPath.removeLast()
                            }
                        }) {
                            Text("Crear Proyecto")
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color(red: 0, green: 0.94, blue: 1))
                                .foregroundColor(Color(red: 0.043, green: 0.055, blue: 0.09))
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct FormField: View {
    let label: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)

            TextField(placeholder, text: $text)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder).foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                }
                .padding(12)
                .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                .cornerRadius(8)
        }
    }
}

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct ProjectDetailView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String

    let floors = [1, 2, 3]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Atrás")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Casa Residencial Ló...")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                ScrollView {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("[FICHA TÉCNICA]")
                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                                Spacer()

                                Text("Casa")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                    .cornerRadius(6)
                            }

                            VStack(spacing: 8) {
                                DetailRow(label: "Dirección", value: "Av. Reforma 245, Centro")
                                DetailRow(label: "Responsable", value: "Arq. Carlos M.")
                                DetailRow(label: "Creación", value: "24 OCT 2025")
                            }
                        }
                        .padding(16)
                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                        .cornerRadius(12)

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Plantas")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)

                                Spacer()

                                Text("3 Total")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                            }

                            VStack(spacing: 12) {
                                ForEach(floors, id: \.self) { floor in
                                    Button(action: {
                                        navigationPath.append(.floorDetail(projectID, floor))
                                    }) {
                                        HStack {
                                            Image(systemName: "square.stack.3d.up.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("Planta \(floor)")
                                                    .font(.system(size: 14, weight: .bold))
                                                    .foregroundColor(.white)

                                                Text("\(4 - floor) espacios analizados")
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                                            }

                                            Spacer()

                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                        }
                                        .padding(16)
                                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                        .cornerRadius(12)
                                    }
                                }
                            }
                        }
                    }
                    .padding(24)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

            Spacer()

            Text(value)
                .font(.system(size: 12, weight: .regular, design: .monospaced))
                .foregroundColor(.white)
        }
    }
}

struct FloorDetailView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String
    var floorNumber: Int

    let mockSpaces = [
        ("Cuarto Principal", "3 paredes de concreto, 1 ventana, piso rústico", 2),
        ("Sala", "4 paredes de concreto, techado libre, cableado listo", 1),
        ("Cocina", "Piso cerámico, ducto de gas instalado, 2 tomas de agua", 3)
    ]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Atrás")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Spacer()

                    Text("Planta \(floorNumber)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                ScrollView {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "dot.circle.fill")
                                .font(.system(size: 8))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Text("MODO LIDAR 3D ACTIVO")
                                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Spacer()

                            Text("98.4% ACC.")
                                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                        }
                        .padding(12)
                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Espacios")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)

                                Spacer()

                                Button(action: {
                                    navigationPath.append(.createSpace(projectID, floorNumber))
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 12, weight: .semibold))
                                        Text("Crear Espacio")
                                            .font(.system(size: 12, weight: .semibold))
                                    }
                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                }
                            }

                            VStack(spacing: 12) {
                                ForEach(mockSpaces, id: \.0) { spaceName, description, analysisCount in
                                    VStack(alignment: .leading, spacing: 12) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(spaceName)
                                                    .font(.system(size: 14, weight: .bold))
                                                    .foregroundColor(.white)

                                                Text("\(analysisCount) análisis")
                                                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                            }

                                            Spacer()
                                        }

                                        Text(description)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                                            .lineLimit(2)

                                        HStack(spacing: 12) {
                                            Button(action: {
                                                navigationPath.append(.spaceDetail(projectID, floorNumber, spaceName))
                                            }) {
                                                Text("Ver Detalles")
                                                    .font(.system(size: 12, weight: .semibold))
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 40)
                                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                                    .background(Color(red: 0.043, green: 0.055, blue: 0.09))
                                                    .border(Color(red: 0, green: 0.94, blue: 1), width: 1)
                                                    .cornerRadius(8)
                                            }

                                            Button(action: {
                                                navigationPath.append(.scanning(projectID, floorNumber, spaceName))
                                            }) {
                                                HStack(spacing: 6) {
                                                    Image(systemName: "circle.fill")
                                                        .font(.system(size: 8))
                                                    Text("Analizar")
                                                        .font(.system(size: 12, weight: .semibold))
                                                }
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 40)
                                                .foregroundColor(Color(red: 0.043, green: 0.055, blue: 0.09))
                                                .background(Color(red: 0, green: 0.94, blue: 1))
                                                .cornerRadius(8)
                                            }
                                        }
                                    }
                                    .padding(16)
                                    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                    .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding(24)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct CreateSpaceView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String
    var floorNumber: Int
    @State private var spaceName = ""

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Text("Nuevo Espacio")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                Spacer()

                VStack(spacing: 20) {
                    Text("¿Cómo se llama este espacio?")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)

                    TextField("Ej: Sala, Cocina, Recámara", text: $spaceName)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .placeholder(when: spaceName.isEmpty) {
                            Text("Ej: Sala, Cocina, Recámara").foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                        }
                        .padding(16)
                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                        .cornerRadius(12)

                    Button(action: {
                        if !spaceName.isEmpty {
                            navigationPath.append(.spaceTypeSelect(projectID, floorNumber, spaceName))
                        }
                    }) {
                        Text("Continuar")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(spaceName.isEmpty ? Color(red: 0.1, green: 0.12, blue: 0.15) : Color(red: 0, green: 0.94, blue: 1))
                            .foregroundColor(spaceName.isEmpty ? Color(red: 0.56, green: 0.61, blue: 0.70) : Color(red: 0.043, green: 0.055, blue: 0.09))
                            .cornerRadius(12)
                    }
                    .disabled(spaceName.isEmpty)
                }
                .padding(24)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct SpaceTypeSelectView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String
    var floorNumber: Int
    var spaceName: String

    let spaceTypes = [
        ("square.fill", "Piso", "Medidas de piso"),
        ("square.grid.2x2", "Ventana", "Dimensiones de ventana"),
        ("square.split.2x1", "Muro", "Área de muro")
    ]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Text("Tipo de Medición")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                Spacer()

                VStack(spacing: 20) {
                    Text("¿Qué deseas escanear en '\(spaceName)'?")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    VStack(spacing: 16) {
                        ForEach(spaceTypes, id: \.1) { icon, type, description in
                            Button(action: {
                                navigationPath.append(.scanning(projectID, floorNumber, spaceName))
                            }) {
                                VStack(spacing: 12) {
                                    Image(systemName: icon)
                                        .font(.system(size: 40))
                                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                                    VStack(spacing: 4) {
                                        Text(type)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)

                                        Text(description)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 140)
                                .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                .cornerRadius(16)
                            }
                        }
                    }
                }
                .padding(24)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ScanningView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String
    var floorNumber: Int
    var spaceName: String

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Text("Analizando: \(spaceName)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                VStack(spacing: 12) {
                    VStack {
                        CameraView()
                            .cornerRadius(12)
                            .clipped()
                    }
                    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                    .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "dot.circle.fill")
                                .font(.system(size: 8))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Text("Cámara Trasera Activa")
                                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                        }
                    }
                    .padding(12)
                    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                    .cornerRadius(8)
                }
                .padding(24)

                Spacer().frame(height: 12)

                VStack(spacing: 12) {
                    Button(action: {
                        navigationPath.append(.analysisResult(projectID, floorNumber, spaceName))
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 8))
                            Text("Analizar")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .foregroundColor(Color(red: 0.043, green: 0.055, blue: 0.09))
                        .background(Color(red: 0, green: 0.94, blue: 1))
                        .cornerRadius(12)
                    }
                }
                .padding(24)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct AnalysisResultView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String
    var floorNumber: Int
    var spaceName: String
    @State private var selectedStage = "Gris"

    let constructionStages = ["Negra", "Gris", "Blanca"]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Escaneo")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Spacer()

                    Text("Resultado del Análi...")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                ScrollView {
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "cube.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Color(red: 0.8, green: 0.4, blue: 0.2))

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Muro Escaneado")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)

                                Text("ID: ESPACIO_04_MURO")
                                    .font(.system(size: 11, weight: .regular, design: .monospaced))
                                    .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                            }
                        }
                        .padding(12)
                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("DIMENSIONES DETECTADAS")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            VStack(spacing: 8) {
                                DimensionRow(label: "Ancho", value: "3.20 m")
                                DimensionRow(label: "Alto", value: "2.85 m")
                                DimensionRow(label: "Área de Superficie", value: "9.12 m²", highlighted: true)
                                DimensionRow(label: "Perímetro", value: "12.10 m")
                            }
                        }
                        .padding(16)
                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Condición de Obra")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)

                            HStack(spacing: 8) {
                                ForEach(constructionStages, id: \.self) { stage in
                                    Button(action: { selectedStage = stage }) {
                                        Text(stage)
                                            .font(.system(size: 12, weight: .semibold))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 40)
                                            .foregroundColor(selectedStage == stage ? Color(red: 0.043, green: 0.055, blue: 0.09) : Color(red: 0, green: 0.94, blue: 1))
                                            .background(selectedStage == stage ? Color(red: 0, green: 0.94, blue: 1) : Color(red: 0.043, green: 0.055, blue: 0.09))
                                            .border(Color(red: 0, green: 0.94, blue: 1), width: 1)
                                            .cornerRadius(6)
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("MATERIALES ESTIMADOS")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Text("Basado en Obra Gris")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

                            VStack(spacing: 8) {
                                MaterialRowResult(name: "Cemento", value: "4 sacos")
                                MaterialRowResult(name: "Arena", value: "0.5 m³")
                                MaterialRowResult(name: "Pintura", value: "2.5 galones")
                                MaterialRowResult(name: "Mortero", value: "3 sacos")
                            }
                        }
                    }
                    .padding(24)
                }

                VStack(spacing: 12) {
                    Button(action: {
                        navigationPath.append(.analysisSaved(projectID, floorNumber, spaceName))
                    }) {
                        Text("Guardar Análisis")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .foregroundColor(Color(red: 0.043, green: 0.055, blue: 0.09))
                            .background(Color(red: 0, green: 0.94, blue: 1))
                            .cornerRadius(12)
                    }

                    Button(action: {
                        navigationPath.removeLast()
                    }) {
                        Text("Volver a Escanear")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                            .background(Color(red: 0.043, green: 0.055, blue: 0.09))
                            .border(Color(red: 0, green: 0.94, blue: 1), width: 1)
                            .cornerRadius(12)
                    }
                }
                .padding(24)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct DimensionRow: View {
    let label: String
    let value: String
    var highlighted: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

            Spacer()

            Text(value)
                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                .foregroundColor(highlighted ? Color(red: 0, green: 0.94, blue: 1) : .white)
        }
    }
}

struct MaterialRowResult: View {
    let name: String
    let value: String

    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.white)

            Spacer()

            Text(value)
                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
        }
    }
}

struct AnalysisSavedView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String
    var floorNumber: Int
    var spaceName: String

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast(3) }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Text("Completado")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                Spacer()

                VStack(spacing: 24) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                    VStack(spacing: 8) {
                        Text("¡Análisis Guardado!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)

                        Text("Se guardó el análisis de \(spaceName) en planta \(floorNumber)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                            .multilineTextAlignment(.center)
                    }

                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Text("Dimensiones registradas")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

                            Spacer()
                        }

                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Text("Materiales calculados")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

                            Spacer()
                        }

                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Text("Datos encriptados")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

                            Spacer()
                        }
                    }
                    .padding(16)
                    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                    .cornerRadius(12)
                }
                .padding(24)

                Spacer()

                VStack(spacing: 12) {
                    Button(action: {
                        navigationPath.removeLast(3)
                    }) {
                        Text("Ver Proyecto")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color(red: 0, green: 0.94, blue: 1))
                            .foregroundColor(Color(red: 0.043, green: 0.055, blue: 0.09))
                            .cornerRadius(12)
                    }

                    Button(action: {
                        navigationPath.removeLast(3)
                    }) {
                        Text("Escanear Otro Espacio")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                            .cornerRadius(12)
                    }
                }
                .padding(24)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct SpaceDetailView: View {
    @Binding var navigationPath: [NavigationScreen]
    var projectID: String
    var floorNumber: Int
    var spaceName: String

    let mockAnalyses = [
        ("cube.fill", "Muro Lateral Izq.", "Obra Gris", "9.12 m²", "15 SEP 2026"),
        ("square.fill", "Piso Habitación", "Obra Negra", "16.80 m²", "12 SEP 2026"),
        ("square.grid.2x2", "Ventana Frontal", "Obra Blanca", "2.40 m²", "10 SEP 2026")
    ]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: { navigationPath.removeLast() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Atrás")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text(spaceName)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)

                        Text("Planta \(floorNumber) • Casa Residencial López")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)

                ScrollView {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Dossier del Espacio")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                            Text("3 paredes de concreto, 1 ventana, piso repellado")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                        }
                        .padding(12)
                        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Análisis Guardados")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)

                                Spacer()

                                Text("3 Scans")
                                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                    .cornerRadius(6)
                            }

                            VStack(spacing: 12) {
                                ForEach(mockAnalyses, id: \.1) { icon, name, stage, measurement, date in
                                    VStack(alignment: .leading, spacing: 12) {
                                        HStack {
                                            Image(systemName: icon)
                                                .font(.system(size: 18))
                                                .foregroundColor(Color(red: 0.8, green: 0.4, blue: 0.2))

                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(name)
                                                    .font(.system(size: 14, weight: .bold))
                                                    .foregroundColor(.white)
                                            }

                                            Spacer()

                                            Text(stage)
                                                .font(.system(size: 10, weight: .semibold, design: .monospaced))
                                                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 3)
                                                .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                                .cornerRadius(4)
                                        }

                                        HStack {
                                            Text("Medidas: \(measurement)")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

                                            Spacer()

                                            Text(date)
                                                .font(.system(size: 11, weight: .regular))
                                                .foregroundColor(Color(red: 0.314, green: 0.388, blue: 0.482))
                                        }
                                    }
                                    .padding(12)
                                    .background(Color(red: 0.067, green: 0.098, blue: 0.145))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding(24)
                }

                VStack(spacing: 12) {
                    Button(action: {
                        navigationPath.append(.scanning(projectID, floorNumber, spaceName))
                    }) {
                        Text("Nuevo Análisis")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .foregroundColor(Color(red: 0.043, green: 0.055, blue: 0.09))
                            .background(Color(red: 0, green: 0.94, blue: 1))
                            .cornerRadius(12)
                    }
                }
                .padding(24)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct MeasurementBox: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))

            Text(value)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
        .cornerRadius(8)
    }
}
