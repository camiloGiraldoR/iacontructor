//
//  ToastView.swift
//  IAConstructor
//
//  Reusable toast notification component
//

import SwiftUI
import Combine

class ToastManager: ObservableObject {
    @Published var message: String = ""
    @Published var isShowing: Bool = false

    func show(_ message: String) {
        self.message = message
        self.isShowing = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isShowing = false
        }
    }
}

struct ToastView: View {
    @ObservedObject var toastManager: ToastManager

    var body: some View {
        VStack {
            if toastManager.isShowing {
                VStack {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 0, green: 0.94, blue: 1))

                        Text(toastManager.message)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(16)
                    .background(Color(red: 0.1, green: 0.12, blue: 0.15))
                    .cornerRadius(12)
                }
                .padding(16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            Spacer()
        }
        .ignoresSafeArea()
    }
}
