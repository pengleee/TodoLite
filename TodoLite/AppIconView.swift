//
//  AppIconView.swift
//  TodoLite
//
//  Created by pengli on 9/27/25.
//

import SwiftUI

enum AppIconTheme {
    case light
    case dark
}

struct AppIconView: View {
    var theme: AppIconTheme = .light

    var body: some View {
        GeometryReader { proxy in
            let size = min(proxy.size.width, proxy.size.height)
            let corner = size * 0.22 // rounded corner similar to a squircle
            let gradientColors: [Color] = (theme == .light) ? [Color.green, Color.teal] : [Color.indigo, Color.blue]
            let borderOpacity: Double = (theme == .light) ? 0.15 : 0.08
            let highlightOpacity: Double = (theme == .light) ? 0.18 : 0.10
            let circleOpacity: Double = (theme == .light) ? 0.18 : 0.12
            let glyphSecondaryOpacity: Double = (theme == .light) ? 0.35 : 0.25

            ZStack {
                // Background
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: corner, style: .continuous)
                            .strokeBorder(.white.opacity(borderOpacity), lineWidth: size * 0.01)
                    )
                    .shadow(color: .black.opacity(0.12), radius: size * 0.06, x: 0, y: size * 0.03)

                // Soft highlight
                RoundedRectangle(cornerRadius: corner, style: .continuous)
                    .fill(
                        LinearGradient(colors: [Color.white.opacity(highlightOpacity), .clear], startPoint: .top, endPoint: .center)
                    )
                    .blendMode(.plusLighter)
                    .allowsHitTesting(false)

                // Glyph backdrop
                Circle()
                    .fill(Color.white.opacity(circleOpacity))
                    .frame(width: size * 0.56, height: size * 0.56)

                // Glyph
                Image(systemName: "checkmark.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color.white.opacity(glyphSecondaryOpacity))
                    .font(.system(size: size * 0.42, weight: .semibold, design: .rounded))
                    .shadow(color: .black.opacity(0.15), radius: size * 0.03, x: 0, y: size * 0.015)
            }
            .frame(width: size, height: size)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview("App Icon 1024") {
    AppIconView()
        .frame(width: 1024, height: 1024)
}

#Preview("App Icon 256") {
    AppIconView()
        .frame(width: 256, height: 256)
}

#Preview("App Icon 512") {
    AppIconView()
        .frame(width: 512, height: 512)
}

#Preview("App Icon 128") {
    AppIconView()
        .frame(width: 128, height: 128)
}

#Preview("App Icon 64") {
    AppIconView()
        .frame(width: 64, height: 64)
}

#Preview("App Icon 32") {
    AppIconView()
        .frame(width: 32, height: 32)
}

#Preview("App Icon 16") {
    AppIconView()
        .frame(width: 16, height: 16)
}

#Preview("App Icon 1024 - Dark") {
    AppIconView(theme: .dark)
        .frame(width: 1024, height: 1024)
}

#Preview("App Icon 256 - Dark") {
    AppIconView(theme: .dark)
        .frame(width: 256, height: 256)
}
