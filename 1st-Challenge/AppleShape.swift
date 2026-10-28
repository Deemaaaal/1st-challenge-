//
//  AppleShape.swift
//  OnboardingPage
//
//  Created by deemaalqassem on 16/05/1448 AH.
//

import SwiftUI

struct Appleshape: View {
    let backgroundColor = Color(red: 0.98, green: 0.97, blue: 0.95)
    let orange = Color(red: 209.0 / 255.0, green: 113.0 / 255.0, blue: 24.0 / 255.0)
    let cardColor = Color(red: 0.93, green: 0.90, blue: 0.85)
    let dark = Color(red: 0.17, green: 0.16, blue: 0.15)

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Apple-Shape")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                ZStack(alignment: .bottomLeading) {
                    Image("Appleshape")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)

                    Text("Likely to fit")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(dark)
                        .clipShape(Capsule())
                }

                VStack(alignment: .leading) {
                    Text("Fit")
                        .font(.system(size: 20, weight: .bold))
                }
                .frame(maxWidth: .infinity, minHeight: 110, alignment: .topLeading)
                .padding(20)
                .background(cardColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading) {
                    Text("Flattery and styling")
                        .font(.system(size: 20, weight: .bold))
                }
                .frame(maxWidth: .infinity, minHeight: 110, alignment: .topLeading)
                .padding(20)
                .background(cardColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Spacer()

                // Retake photo يودّي للكاميرا
                NavigationLink {
                    DoesItFit()
                } label: {
                    Text("Retake photo")
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(orange)
                        .clipShape(Capsule())
                }

                // Back يودّي للبروفايل
                NavigationLink {
                    profile_page()
                } label: {
                    Text("Profile")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.black)
                }

            }
            .padding(.horizontal, 24)
            .padding(.bottom, 18)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        Appleshape()
    }
    .environment(OnboardingData())
}
