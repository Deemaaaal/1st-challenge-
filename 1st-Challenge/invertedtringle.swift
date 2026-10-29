//
//  invertedtringle.swift
//  OnboardingPage
//
//  Created by deemaalqassem on 16/05/1448 AH.
//

import SwiftUI

struct InvertedTringleType: View {
    let image: UIImage
    var backToProfile: () -> Void = {}

    @Environment(\.dismiss) private var dismiss

    let backgroundColor = Color(red: 0.98, green: 0.97, blue: 0.95)

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Inverted Triangle-Type")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                GarmentResult(image: image, bodyShape: .invertedTriangle, illustration: "IntevedtringleShape")

                Spacer()

                VStack(spacing: 6) {
                    // Retake photo يودّي للكاميرا
                    Button("Retake photo") {
                        dismiss()
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    // Profile يودّي للبروفايل
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
        InvertedTringleType(image: UIImage())
    }
    .environment(OnboardingData())
}
