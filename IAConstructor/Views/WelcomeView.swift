//
//  WelcomeView.swift
//  IAConstructor
//

import SwiftUI

struct WelcomeView: View {
    @Binding var navigationPath: [NavigationScreen]

    var body: some View {
        ZStack {
            Color(red: 0.043, green: 0.055, blue: 0.09)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 40) {
                    LogoSection()
                    WelcomeContentSection()
                }
                .padding(.horizontal, 24)

                Spacer()

                WelcomeActionSection(navigationPath: $navigationPath)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct LogoSection: View {
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(Color(red: 0, green: 0.94, blue: 1), lineWidth: 3)
                    .frame(width: 100, height: 100)

                Circle()
                    .stroke(Color(red: 0, green: 0.94, blue: 1).opacity(0.3), lineWidth: 1)
                    .frame(width: 68, height: 68)

                Image(systemName: "circle.grid.2x2")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))
            }

            VStack(spacing: 4) {
                Text("IACONSTRUCTOR")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .tracking(1)
                    .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                Text("¡Bienvenido!")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
            }
        }
    }
}

struct WelcomeContentSection: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Tu asistente inteligente de construcción. Utiliza la cámara y tecnología LiDAR para medir espacios, analizar condiciones y estimar materiales.")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                .lineSpacing(6)
                .multilineTextAlignment(.center)

            HStack(spacing: 8) {
                Circle()
                    .fill(Color(red: 0, green: 0.94, blue: 1))
                    .frame(width: 10, height: 10)

                Text("Compatible con Apple LiDAR & ARKit")
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundColor(.white)
            }
            .padding(12)
            .background(Color(red: 0.067, green: 0.098, blue: 0.145))
            .cornerRadius(10)
        }
    }
}

struct WelcomeActionSection: View {
    @Binding var navigationPath: [NavigationScreen]

    var body: some View {
        VStack(spacing: 16) {
            Button(action: {
                navigationPath.append(.projectList)
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 20))
                    Text("Comencemos")
                        .font(.system(size: 16, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color(red: 0, green: 0.94, blue: 1))
                .foregroundColor(Color(red: 0.043, green: 0.055, blue: 0.09))
                .cornerRadius(12)
            }

            Text("CONEXIÓN DE DATOS ENCRIPTADA")
                .font(.system(size: 11, weight: .regular, design: .monospaced))
                .foregroundColor(Color(red: 0.56, green: 0.61, blue: 0.70))
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
    }
}

#Preview {
    WelcomeView(navigationPath: .constant([]))
}
