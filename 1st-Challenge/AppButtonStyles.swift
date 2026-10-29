//
//  AppButtonStyles.swift
//  OnboardingPage
//

import SwiftUI

/// Main orange button used on every screen.
struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    private let orange = Color(red: 209.0 / 255.0, green: 113.0 / 255.0, blue: 24.0 / 255.0)
    private let disabledOrange = Color(red: 0.90, green: 0.75, blue: 0.65)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 19, weight: .semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(isEnabled ? orange : disabledOrange)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

/// Text button shown under the main button (Back, Profile).
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 42)
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}
