//
//  AppleShape.swift
//  OnboardingPage
//
//  Created by deemaalqassem on 16/05/1448 AH.
//

import SwiftUI

struct Appleshape: View {
    let image: UIImage
    var backToProfile: () -> Void = {}

    @Environment(\.dismiss) private var dismiss

    let backgroundColor = Color(red: 0.98, green: 0.97, blue: 0.95)

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Your Results")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                GarmentResult(image: image, bodyShape: .apple)

                VStack(spacing: 6) {
                    // Retake photo يودّي للكاميرا
                    Button("Retake photo") {
                        dismiss()
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    // Back يودّي للبروفايل
                    Button("Profile") {
                        backToProfile()
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }

            }
            .padding(.horizontal, 24)
            .padding(.bottom, 6)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        Appleshape(image: UIImage())
    }
    .environment(OnboardingData())
}
