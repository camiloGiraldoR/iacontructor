//
//  ContentView.swift
//  IAConstructor
//
//  Created by Camilo Giraldo on 25/09/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 25) {
            // Icono o ilustración de bienvenida
            Image(systemName: "hand.wave.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            // Título principal
            Text("¡Bienvenido a IAConstructor!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            // Descripción breve
            Text("Estamos felices de tenerte aquí. Comienza a explorar y crea proyectos increíbles con facilidad.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Spacer()
            
            // Botón de acción principal
            Button(action: {
                // Aquí puedes agregar la acción del botón
                print("Botón presionado")
            }) {
                Text("Comenzar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
