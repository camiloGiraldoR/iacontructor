//
//  ProjectListView.swift
//  IAConstructor
//

import SwiftUI

struct ProjectListView: View {
    @Binding var navigationPath: [NavigationScreen]

    let mockProjects = [
        ProjectListItem(id: "proj_1", name: "Casa Residencial López", address: "Av. Reforma 245, Centro", type: "Casa", floors: 3, icon: "🏠"),
        ProjectListItem(id: "proj_2", name: "Edificio Corporativo Alestra", address: "Paseo de la Marina 102", type: "Edificio", floors: 12, icon: "🏢"),
        ProjectListItem(id: "proj_3", name: "Oficinas Tecnológicas S.A.", address: "Industrial Park Monterrey", type: "Oficina", floors: 2, icon: "🏢")
    ]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ProjectListHeader(navigationPath: $navigationPath)

                ScrollView {
                    VStack(spacing: 16) {
                        ProjectMetricsRow()
                        ProjectCardsStack(projects: mockProjects, navigationPath: $navigationPath)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                }

                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ProjectListHeader: View {
    @Binding var navigationPath: [NavigationScreen]

    var body: some View {
        HStack {
            Text("Mis Proyectos")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)

            Spacer()

            Button(action: {
                navigationPath.append(.createProject)
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
                    .frame(width: 36, height: 36)
                    .background(Color(red: 0, green: 0.94, blue: 1).opacity(0.13))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
    }
}

struct ProjectMetricsRow: View {
    var body: some View {
        HStack(spacing: 12) {
            MetricBox(number: "03", label: "Proyectos")
            MetricBox(number: "17", label: "Espacios Scan")
            Spacer()
        }
    }
}

struct MetricBox: View {
    let number: String
    let label: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(number)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
            Text(label)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
        }
        .padding(12)
        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
        .cornerRadius(12)
    }
}

struct ProjectCardsStack: View {
    let projects: [ProjectListItem]
    @Binding var navigationPath: [NavigationScreen]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(projects) { project in
                ProjectCard(project: project, navigationPath: $navigationPath)
            }
        }
    }
}

struct ProjectCard: View {
    let project: ProjectListItem
    @Binding var navigationPath: [NavigationScreen]

    var body: some View {
        Button(action: {
            navigationPath.append(.projectDetail(project.id))
        }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(project.name)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(1)

                        Text(project.address)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                            .lineLimit(1)
                    }

                    Spacer()

                    ProjectIconBox(icon: project.icon, type: project.type)
                }

                Divider()
                    .background(Color(red: 0.56, green: 0.61, blue: 0.70).opacity(0.2))

                HStack {
                    Image(systemName: "square.stack.3d.up.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                    Text("\(project.floors) Plantas")
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                    Spacer()

                    Text("24 OCT 2025")
                        .font(.system(size: 11, weight: .regular, design: .monospaced))
                        .foregroundColor(Color(red: 0.314, green: 0.388, blue: 0.482))
                }
            }
            .padding(16)
            .background(Color(red: 0.067, green: 0.098, blue: 0.145))
            .cornerRadius(16)
        }
    }
}

struct ProjectIconBox: View {
    let icon: String
    let type: String

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(icon)
                .font(.system(size: 28))

            Text(type)
                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
        }
        .frame(width: 56, height: 56)
        .background(Color(red: 0.067, green: 0.098, blue: 0.145))
        .cornerRadius(12)
    }
}

struct ProjectListItem: Identifiable {
    let id: String
    let name: String
    let address: String
    let type: String
    let floors: Int
    let icon: String
}

#Preview {
    ProjectListView(navigationPath: .constant([]))
}
